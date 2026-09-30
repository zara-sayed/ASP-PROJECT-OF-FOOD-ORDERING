using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace FoodOrdering
{
    public partial class Admin : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["AdminId"] == null)
            {
                Response.Redirect("AdminLogin.aspx");
                return;
            }

            if (!IsPostBack)
            {
                litAdminName.Text = Convert.ToString(Session["AdminName"]);
                LoadAll();
            }
        }

        private void LoadAll()
        {
            LoadStats();
            LoadFoods();
            LoadOrders();
        }

        private void LoadStats()
        {
            using (SqlConnection con = Db.GetConnection())
            {
                con.Open();

                using (SqlCommand cmd = new SqlCommand("SELECT COUNT(*) FROM FoodItems", con))
                    litFoods.Text = Convert.ToString(cmd.ExecuteScalar());

                using (SqlCommand cmd = new SqlCommand("SELECT COUNT(*) FROM FoodItems WHERE IsAvailable=1", con))
                    litAvailable.Text = Convert.ToString(cmd.ExecuteScalar());

                using (SqlCommand cmd = new SqlCommand("SELECT COUNT(*) FROM Orders", con))
                    litOrders.Text = Convert.ToString(cmd.ExecuteScalar());

                using (SqlCommand cmd = new SqlCommand("SELECT ISNULL(SUM(TotalAmount),0) FROM Orders", con))
                    litSales.Text = Convert.ToDecimal(cmd.ExecuteScalar()).ToString("0.00");
            }
        }

        private void LoadFoods()
        {
            using (SqlConnection con = Db.GetConnection())
            using (SqlCommand cmd = new SqlCommand(
                "SELECT FoodId, FoodName, Category, Price, IsAvailable FROM FoodItems ORDER BY FoodId", con))
            using (SqlDataAdapter da = new SqlDataAdapter(cmd))
            {
                DataTable dt = new DataTable();
                da.Fill(dt);
                rptFoods.DataSource = dt;
                rptFoods.DataBind();
            }
        }

        private void LoadOrders()
        {
            using (SqlConnection con = Db.GetConnection())
            using (SqlCommand cmd = new SqlCommand(
                "SELECT OrderId, CustomerName, Phone, TotalAmount, PaymentMethod, OrderStatus FROM Orders ORDER BY OrderDate DESC", con))
            using (SqlDataAdapter da = new SqlDataAdapter(cmd))
            {
                DataTable dt = new DataTable();
                da.Fill(dt);
                gvOrders.DataSource = dt;
                gvOrders.DataBind();
            }
        }

        protected void btnAddFood_Click(object sender, EventArgs e)
        {
            string foodName = txtFoodName.Text.Trim();
            string category = txtCategory.Text.Trim();
            string description = txtDescription.Text.Trim();
            string imageUrl = txtImageUrl.Text.Trim();
            decimal price;

            if (foodName == "" || category == "")
            {
                Show("Please enter food name and category.", true);
                return;
            }

            if (!decimal.TryParse(txtPrice.Text.Trim(), out price) || price < 0)
            {
                Show("Please enter a valid INR price.", true);
                return;
            }

            if (imageUrl == "")
            {
                imageUrl = "https://images.unsplash.com/photo-1504674900247-0877df9cc836?auto=format&fit=crop&w=900&q=85";
            }

            try
            {
                int newFoodId;

                using (SqlConnection con = Db.GetConnection())
                using (SqlCommand cmd = new SqlCommand(@"
                    INSERT INTO FoodItems
                        (FoodName, Description, Category, Price, ImageUrl, IsAvailable)
                    OUTPUT INSERTED.FoodId
                    VALUES
                        (@FoodName, @Description, @Category, @Price, @ImageUrl, 1);", con))
                {
                    cmd.Parameters.Add("@FoodName", SqlDbType.NVarChar, 100).Value = foodName;
                    cmd.Parameters.Add("@Description", SqlDbType.NVarChar, 300).Value =
                        description == "" ? (object)DBNull.Value : description;
                    cmd.Parameters.Add("@Category", SqlDbType.NVarChar, 40).Value = category;

                    SqlParameter priceParameter = cmd.Parameters.Add("@Price", SqlDbType.Decimal);
                    priceParameter.Precision = 10;
                    priceParameter.Scale = 2;
                    priceParameter.Value = price;

                    cmd.Parameters.Add("@ImageUrl", SqlDbType.NVarChar, 500).Value = imageUrl;

                    con.Open();
                    newFoodId = Convert.ToInt32(cmd.ExecuteScalar());
                }

                ClearFoodForm();

                // Reload from SQL Server so the newly inserted item is immediately visible
                // in the admin list and available on the public Menu page.
                LoadAll();

                Show("Food item added successfully. Food ID: " + newFoodId, false);
            }
            catch (Exception ex)
            {
                Show("Food item could not be added. Database error: " + ex.Message, true);
            }
        }

        protected void rptFoods_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName != "UpdateFood") return;

            int id = Convert.ToInt32(e.CommandArgument);
            TextBox name = e.Item.FindControl("txtName") as TextBox;
            TextBox cat = e.Item.FindControl("txtCat") as TextBox;
            TextBox priceBox = e.Item.FindControl("txtItemPrice") as TextBox;
            CheckBox available = e.Item.FindControl("chkAvailable") as CheckBox;

            decimal price;

            if (name == null || cat == null || priceBox == null ||
                !decimal.TryParse(priceBox.Text.Trim(), out price) || price < 0)
            {
                Show("Please enter a valid food name, category and price.", true);
                return;
            }

            try
            {
                using (SqlConnection con = Db.GetConnection())
                using (SqlCommand cmd = new SqlCommand(@"
                    UPDATE FoodItems
                    SET FoodName=@Name,
                        Category=@Category,
                        Price=@Price,
                        IsAvailable=@Available
                    WHERE FoodId=@FoodId", con))
                {
                    cmd.Parameters.Add("@Name", SqlDbType.NVarChar, 100).Value = name.Text.Trim();
                    cmd.Parameters.Add("@Category", SqlDbType.NVarChar, 40).Value = cat.Text.Trim();

                    SqlParameter priceParameter = cmd.Parameters.Add("@Price", SqlDbType.Decimal);
                    priceParameter.Precision = 10;
                    priceParameter.Scale = 2;
                    priceParameter.Value = price;

                    cmd.Parameters.Add("@Available", SqlDbType.Bit).Value =
                        available != null && available.Checked;
                    cmd.Parameters.Add("@FoodId", SqlDbType.Int).Value = id;

                    con.Open();
                    cmd.ExecuteNonQuery();
                }

                LoadAll();
                Show("Food item updated successfully.", false);
            }
            catch (Exception ex)
            {
                Show("Food item could not be updated. Database error: " + ex.Message, true);
            }
        }

        protected void gvOrders_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName != "UpdateStatus") return;

            GridViewRow row = (GridViewRow)((Control)e.CommandSource).NamingContainer;
            DropDownList ddl = row.FindControl("ddlStatus") as DropDownList;

            if (ddl == null) return;

            try
            {
                using (SqlConnection con = Db.GetConnection())
                using (SqlCommand cmd = new SqlCommand(
                    "UPDATE Orders SET OrderStatus=@Status WHERE OrderId=@OrderId", con))
                {
                    cmd.Parameters.Add("@Status", SqlDbType.NVarChar, 40).Value = ddl.SelectedValue;
                    cmd.Parameters.Add("@OrderId", SqlDbType.Int).Value = Convert.ToInt32(e.CommandArgument);

                    con.Open();
                    cmd.ExecuteNonQuery();
                }

                LoadAll();
                Show("Order status updated successfully.", false);
            }
            catch (Exception ex)
            {
                Show("Order status could not be updated. Database error: " + ex.Message, true);
            }
        }

        protected void btnAdminLogout_Click(object sender, EventArgs e)
        {
            Session.Remove("AdminId");
            Session.Remove("AdminName");
            Response.Redirect("AdminLogin.aspx");
        }

        private void ClearFoodForm()
        {
            txtFoodName.Text = "";
            txtCategory.Text = "";
            txtPrice.Text = "";
            txtImageUrl.Text = "";
            txtDescription.Text = "";
        }

        private void Show(string text, bool error)
        {
            lblMessage.Text = text;
            lblMessage.CssClass = error ? "message error" : "message";
        }
    }
}

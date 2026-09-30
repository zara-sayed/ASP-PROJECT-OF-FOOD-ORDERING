using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

namespace FoodOrdering
{
    public partial class Menu : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack) LoadMenu();
        }

        private void LoadMenu()
        {
            string category = Request.QueryString["category"];
            string sql = "SELECT FoodId, FoodName, Description, Category, Price, ImageUrl FROM FoodItems WHERE IsAvailable=1";
            if (!string.IsNullOrWhiteSpace(category)) sql += " AND Category=@Category";
            sql += " ORDER BY FoodId";

            using (SqlConnection con = Db.GetConnection())
            using (SqlCommand cmd = new SqlCommand(sql, con))
            using (SqlDataAdapter da = new SqlDataAdapter(cmd))
            {
                if (!string.IsNullOrWhiteSpace(category)) cmd.Parameters.AddWithValue("@Category", category);
                DataTable dt = new DataTable();
                da.Fill(dt);
                rptMenu.DataSource = dt;
                rptMenu.DataBind();
            }
        }

        protected void rptMenu_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName != "Add") return;
            int quantity = 1;
            DropDownList ddlQty = e.Item.FindControl("ddlQty") as DropDownList;
            if (ddlQty != null) quantity = Convert.ToInt32(ddlQty.SelectedValue);
            AddToCart(Convert.ToInt32(e.CommandArgument), quantity);
            Response.Redirect("Cart.aspx");
        }

        private void AddToCart(int foodId, int quantity)
        {
            DataTable cart = Session["Cart"] as DataTable;
            if (cart == null)
            {
                cart = new DataTable();
                cart.Columns.Add("FoodId", typeof(int));
                cart.Columns.Add("FoodName", typeof(string));
                cart.Columns.Add("Price", typeof(decimal));
                cart.Columns.Add("Quantity", typeof(int));
                cart.Columns.Add("ImageUrl", typeof(string));
            }

            foreach (DataRow row in cart.Rows)
            {
                if (Convert.ToInt32(row["FoodId"]) == foodId)
                {
                    row["Quantity"] = Convert.ToInt32(row["Quantity"]) + quantity;
                    Session["Cart"] = cart;
                    return;
                }
            }

            using (SqlConnection con = Db.GetConnection())
            using (SqlCommand cmd = new SqlCommand("SELECT FoodId, FoodName, Price, ImageUrl FROM FoodItems WHERE FoodId=@FoodId AND IsAvailable=1", con))
            {
                cmd.Parameters.AddWithValue("@FoodId", foodId);
                con.Open();
                using (SqlDataReader dr = cmd.ExecuteReader())
                {
                    if (dr.Read()) cart.Rows.Add(dr["FoodId"], dr["FoodName"], dr["Price"], quantity, dr["ImageUrl"]);
                }
            }
            Session["Cart"] = cart;
        }
    }
}

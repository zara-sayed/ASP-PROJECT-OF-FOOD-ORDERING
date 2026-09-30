using System;
using System.Data;
using System.Data.SqlClient;
namespace FoodOrdering
{
    public partial class Checkout : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack && Session["UserId"] != null)
            {
                txtName.Text = Convert.ToString(Session["UserName"]);
                txtPhone.Text = Convert.ToString(Session["UserPhone"]);
            }
        }
        protected void btnPlaceOrder_Click(object sender, EventArgs e)
        {
            DataTable cart = Session["Cart"] as DataTable;
            if (cart == null || cart.Rows.Count == 0) { Show("Your cart is empty."); return; }
            string name = txtName.Text.Trim(), phone = txtPhone.Text.Trim(), address = txtAddress.Text.Trim();
            if (name == "" || phone == "" || address == "") { Show("Please enter all delivery details."); return; }

            string paymentMethod = ddlPayment.SelectedValue;
            string paymentReference = "";
            string cardLast4 = "";
            if (paymentMethod == "UPI")
            {
                string upiId = txtUpiId.Text.Trim();
                int at = upiId.IndexOf('@');
                if (upiId.Length < 5 || at <= 0 || at == upiId.Length - 1) { Show("Please enter a valid UPI ID."); return; }
                paymentReference = upiId;
            }
            else if (paymentMethod == "Card")
            {
                string cardName = txtCardName.Text.Trim();
                string cardNumber = txtCardNumber.Text.Replace(" ", "").Replace("-", "").Trim();
                string expiry = txtCardExpiry.Text.Trim();
                string cvv = txtCardCvv.Text.Trim();
                int month; int year; long cardNumberValue; int cvvValue;
                if (cardName == "" || cardNumber.Length < 13 || cardNumber.Length > 19 || !long.TryParse(cardNumber, out cardNumberValue) ||
                    expiry.Length != 5 || expiry[2] != '/' || !int.TryParse(expiry.Substring(0, 2), out month) || !int.TryParse(expiry.Substring(3, 2), out year) || month < 1 || month > 12 ||
                    (cvv.Length != 3 && cvv.Length != 4) || !int.TryParse(cvv, out cvvValue))
                {
                    Show("Please enter valid card details."); return;
                }
                cardLast4 = cardNumber.Substring(cardNumber.Length - 4);
                paymentReference = "Card ending " + cardLast4;
            }

            decimal total = 0;
            foreach (DataRow row in cart.Rows) total += Convert.ToDecimal(row["Price"]) * Convert.ToInt32(row["Quantity"]);
            using (SqlConnection con = Db.GetConnection())
            {
                con.Open(); SqlTransaction tx = con.BeginTransaction();
                try
                {
                    int? userId = Session["UserId"] == null ? (int?)null : Convert.ToInt32(Session["UserId"]);
                    int orderId;
                    using (SqlCommand cmd = new SqlCommand(@"INSERT INTO Orders(UserId,CustomerName,Phone,Address,PaymentMethod,PaymentReference,TotalAmount,OrderStatus) VALUES(@UserId,@Name,@Phone,@Address,@Payment,@PaymentReference,@Total,'Placed'); SELECT CAST(SCOPE_IDENTITY() AS INT);", con, tx))
                    {
                        cmd.Parameters.AddWithValue("@UserId", (object)userId ?? DBNull.Value); cmd.Parameters.AddWithValue("@Name", name); cmd.Parameters.AddWithValue("@Phone", phone); cmd.Parameters.AddWithValue("@Address", address); cmd.Parameters.AddWithValue("@Payment", paymentMethod); cmd.Parameters.AddWithValue("@PaymentReference", (object)paymentReference ?? DBNull.Value); cmd.Parameters.AddWithValue("@Total", total); orderId = Convert.ToInt32(cmd.ExecuteScalar());
                    }
                    foreach (DataRow row in cart.Rows)
                    {
                        using (SqlCommand cmd = new SqlCommand("INSERT INTO OrderDetails(OrderId,FoodId,FoodName,Price,Quantity) VALUES(@OrderId,@FoodId,@FoodName,@Price,@Quantity)", con, tx))
                        {
                            cmd.Parameters.Add("@OrderId", SqlDbType.Int).Value = orderId;
                            cmd.Parameters.Add("@FoodId", SqlDbType.Int).Value = Convert.ToInt32(row["FoodId"]);
                            cmd.Parameters.Add("@FoodName", SqlDbType.NVarChar, 100).Value = row["FoodName"].ToString();
                            cmd.Parameters.Add("@Price", SqlDbType.Decimal).Value = Convert.ToDecimal(row["Price"]);
                            cmd.Parameters["@Price"].Precision = 10; cmd.Parameters["@Price"].Scale = 2;
                            cmd.Parameters.Add("@Quantity", SqlDbType.Int).Value = Convert.ToInt32(row["Quantity"]);
                            int detailRows = cmd.ExecuteNonQuery();
                            if (detailRows != 1) throw new Exception("Order item could not be saved.");
                        }
                    }
                    tx.Commit(); Session.Remove("Cart"); Response.Redirect("OrderSuccess.aspx?id=" + orderId);
                }
                catch (Exception ex) { try { tx.Rollback(); } catch { } Show("The order could not be placed. Please check the database connection and try again."); }
            }
        }
        private void Show(string text) { lblMessage.Text = text; lblMessage.CssClass = "message error"; }
    }
}

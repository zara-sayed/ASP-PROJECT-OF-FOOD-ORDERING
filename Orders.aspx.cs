using System;
using System.Data;
using System.Data.SqlClient;
namespace FoodOrdering
{
    public partial class Orders : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e) { if (!IsPostBack) LoadOrders(); }
        private void LoadOrders()
        {
            if (Session["UserId"] == null) { Response.Redirect("Login.aspx"); return; }
            using (SqlConnection con = Db.GetConnection())
            using (SqlCommand cmd = new SqlCommand("SELECT OrderId, PaymentMethod, TotalAmount, OrderStatus, OrderDate FROM Orders WHERE UserId=@UserId ORDER BY OrderDate DESC", con))
            using (SqlDataAdapter da = new SqlDataAdapter(cmd))
            {
                cmd.Parameters.AddWithValue("@UserId", Convert.ToInt32(Session["UserId"])); DataTable dt = new DataTable(); da.Fill(dt); rptOrders.DataSource = dt; rptOrders.DataBind();
                if (dt.Rows.Count == 0) { lblMessage.Text = "You have not placed any orders yet."; lblMessage.CssClass = "message"; }
            }
        }
    }
}

using System;
namespace FoodOrdering
{
    public partial class OrderSuccess : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string id = Request.QueryString["id"];
                lblOrderId.Text = string.IsNullOrWhiteSpace(id) ? "Order placed successfully." : "Order ID #" + id;
            }
        }
    }
}

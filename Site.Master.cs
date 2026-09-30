using System;
using System.Data;
using System.Web.UI;

namespace FoodOrdering
{
    public partial class SiteMaster : MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            phLoggedIn.Visible = Session["UserId"] != null;
            phLoggedOut.Visible = Session["UserId"] == null;
            UpdateCartCount();
        }

        private void UpdateCartCount()
        {
            int count = 0;
            DataTable cart = Session["Cart"] as DataTable;
            if (cart != null)
            {
                foreach (DataRow row in cart.Rows)
                    count += Convert.ToInt32(row["Quantity"]);
            }
            litCartCount.Text = count.ToString();
        }

        protected void btnLogout_Click(object sender, EventArgs e)
        {
            Session.Clear();
            Response.Redirect("Default.aspx");
        }
    }
}

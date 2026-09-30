using System;
using System.Data;
using System.Web.UI.WebControls;
namespace FoodOrdering
{
    public partial class Cart : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e) { if (!IsPostBack) BindCart(); }
        private void BindCart()
        {
            DataTable cart = Session["Cart"] as DataTable;
            if (cart == null || cart.Rows.Count == 0) { pnlEmpty.Visible = true; pnlCart.Visible = false; return; }
            pnlEmpty.Visible = false; pnlCart.Visible = true;
            DataTable view = cart.Clone();
            view.Columns.Add("SubTotal", typeof(decimal));
            decimal total = 0;
            foreach (DataRow row in cart.Rows)
            {
                DataRow newRow = view.NewRow();
                foreach (DataColumn col in cart.Columns) newRow[col.ColumnName] = row[col.ColumnName];
                decimal subtotal = Convert.ToDecimal(row["Price"]) * Convert.ToInt32(row["Quantity"]);
                newRow["SubTotal"] = subtotal; total += subtotal; view.Rows.Add(newRow);
            }
            gvCart.DataSource = view; gvCart.DataBind();
            lblTotal.Text = total.ToString("0.00"); lblTotal2.Text = total.ToString("0.00");
        }
        protected void gvCart_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName != "RemoveItem") return;
            int index = Convert.ToInt32(e.CommandArgument);
            DataTable cart = Session["Cart"] as DataTable;
            if (cart != null && index >= 0 && index < cart.Rows.Count) cart.Rows.RemoveAt(index);
            Session["Cart"] = cart; BindCart();
        }
    }
}

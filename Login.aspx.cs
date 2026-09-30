using System;
using System.Data.SqlClient;
namespace FoodOrdering
{
    public partial class Login : System.Web.UI.Page
    {
        protected void btnLogin_Click(object sender, EventArgs e)
        {
            string email = txtEmail.Text.Trim();
            string password = txtPassword.Text;
            if (email == "" || password == "") { Show("Please enter your email and password."); return; }

            using (SqlConnection con = Db.GetConnection())
            using (SqlCommand cmd = new SqlCommand("SELECT UserId, FullName, Phone FROM Users WHERE Email=@Email AND PasswordHash=@PasswordHash", con))
            {
                cmd.Parameters.AddWithValue("@Email", email);
                cmd.Parameters.AddWithValue("@PasswordHash", Security.HashPassword(password));
                con.Open();
                using (SqlDataReader dr = cmd.ExecuteReader())
                {
                    if (dr.Read())
                    {
                        Session["UserId"] = Convert.ToInt32(dr["UserId"]);
                        Session["UserName"] = dr["FullName"].ToString();
                        Session["UserPhone"] = dr["Phone"].ToString();
                        Response.Redirect("Default.aspx");
                        return;
                    }
                }
            }
            Show("The email or password is incorrect.");
        }
        private void Show(string text) { lblMessage.Text = text; lblMessage.CssClass = "message error"; }
    }
}

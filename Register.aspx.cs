using System;
using System.Data.SqlClient;
namespace FoodOrdering
{
    public partial class Register : System.Web.UI.Page
    {
        protected void btnRegister_Click(object sender, EventArgs e)
        {
            string name = txtName.Text.Trim();
            string email = txtEmail.Text.Trim();
            string phone = txtPhone.Text.Trim();
            string password = txtPassword.Text;
            if (name == "" || email == "" || phone == "" || password == "") { Show("Please fill in all fields."); return; }
            if (password.Length < 6) { Show("Password must contain at least 6 characters."); return; }

            using (SqlConnection con = Db.GetConnection())
            {
                con.Open();
                using (SqlCommand check = new SqlCommand("SELECT COUNT(*) FROM Users WHERE Email=@Email", con))
                {
                    check.Parameters.AddWithValue("@Email", email);
                    if (Convert.ToInt32(check.ExecuteScalar()) > 0) { Show("An account with this email already exists."); return; }
                }
                using (SqlCommand cmd = new SqlCommand("INSERT INTO Users (FullName, Email, PasswordHash, Phone) VALUES (@Name,@Email,@PasswordHash,@Phone)", con))
                {
                    cmd.Parameters.AddWithValue("@Name", name);
                    cmd.Parameters.AddWithValue("@Email", email);
                    cmd.Parameters.AddWithValue("@PasswordHash", Security.HashPassword(password));
                    cmd.Parameters.AddWithValue("@Phone", phone);
                    cmd.ExecuteNonQuery();
                }
            }
            Response.Redirect("Login.aspx?registered=1");
        }
        private void Show(string text) { lblMessage.Text = text; lblMessage.CssClass = "message error"; }
    }
}

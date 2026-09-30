using System.Configuration;
using System.Data.SqlClient;

namespace FoodOrdering
{
    public static class Db
    {
        public static SqlConnection GetConnection()
        {
            return new SqlConnection(ConfigurationManager.ConnectionStrings["FoodDb"].ConnectionString);
        }
    }
}

using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;

namespace PetsDB_Client
{
    public partial class WebForm1 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        [System.Web.Services.WebMethod]
        public static Pet GetPetById(int petID)
        {
            Pet pet = new Pet();
            string connStr = "server=.;database=PetsDB;integrated security=SSPI";
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                SqlCommand command = new SqlCommand("spGetPetsById", conn);
                command.CommandType = CommandType.StoredProcedure;
                command.Parameters.Add(new SqlParameter()
                {
                    ParameterName = "@Id",
                    Value = petID
                });
                conn.Open();
                SqlDataReader sqlReader = command.ExecuteReader();
                while (sqlReader.Read())
                {
                    pet.ID = Convert.ToInt32(sqlReader["Id"]);
                    pet.Name = sqlReader["Name"].ToString();
                    pet.Species = sqlReader["Species"].ToString();
                    pet.AGe = Convert.ToInt32(sqlReader["Age"]);
                }
            }
            return pet;
        }
    }
}
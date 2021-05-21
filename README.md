# CSharp-Client-for-SQL-Server-Database

1. Add Jquery library to the project
2. Add a new class to the project called Pet.cs

The following code should be added to the Pet class
```csharp
    public class Pet
    {
        public int ID { get; set; }
        public string Name { get; set; }
        public string Species { get; set; }
        public int AGe { get; set; }
    }
```

3. Add the following namespaces to the WebForm1.aspx.cs file: System.Data and System.Data.SqlClient 
4. Create and add the code for the GetPetById method in the WebForm1 class

The WebForm1 class should look as follows:
```csharp
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
```

5. Modify the WebForm1.aspx file to include a table to hold our Pet's information and the AJAX code to populate the table

The file should look like the following:



```html
<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="WebForm1.aspx.cs" Inherits="PetsDB_Client.WebForm1" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>MY PET DATABASE CLIENT</title>
    <script src="jquery-1.11.2.js"></script>
    <script type="text/javascript">
        $(document).ready(function () {
            $('#btnGetPet').click(function () {
                var petId = $('#inputID').val();

                $.ajax({
                    url: 'WebForm1.aspx/GetPetById',
                    method: 'post',
                    contentType: 'application/json',
                    data: '{petID:' + petId + '}',
                    dataType: 'json',
                    success: function (data) {
                        $('#outputName').val(data.d.Name);
                        $('#outputSpecies').val(data.d.Species);
                        $('#outputAge').val(data.d.AGe);
                    },
                    error: function (error) {
                        alert(error);
                    }
                })
            })
        })
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            ID :
            <input id="inputID" type="text" style="width: 100px"/>
            <input type="button" id="btnGetPet" value="Get Pet Information" />
            <br />
            <br />
            <table border="1" style="border-block: groove">
                <tr>
                    <td>Name</td>
                    <td><input id="outputName" type="text" /></td>

                </tr>
                <tr>
                    <td>Species</td>
                    <td><input id="outputSpecies" type="text" /></td>
                </tr>
                <tr>
                    <td>Age</td>
                    <td><input id="outputAge" type="text" /></td>
                </tr>
            </table>
        </div>
    </form>
</body>
</html>
```

6. Run the program and ensure proper functionality.

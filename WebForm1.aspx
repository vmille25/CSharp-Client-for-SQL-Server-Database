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

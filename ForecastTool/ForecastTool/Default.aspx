<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="ForecastTool._Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <script src="Scripts/jquery-1.10.2.js"></script>
    <link rel="stylesheet" type="text/css" href="//cdn.datatables.net/1.10.16/css/jquery.dataTables.min.css" />
    <script type="text/javascript" src="//cdn.datatables.net/1.10.16/js/jquery.dataTables.min.js"></script>
    <script type="text/javascript">
        $(document).ready(function () {
            getAllResources();

            $('#addResBtn').click(function () {
                var resource = {}
                resource.ResourceName = $('#name').val();
                $.ajax({
                    url: 'ResourceService.asmx/InsertResource',
                    method: 'post',
                    contentType: 'application/json;charset=utf-8',
                    data: '{res:' + JSON.stringify(resource) + '}',
                    success: function () {
                        getAllResources();
                    }
                })
            })
        });

        function getAllResources()
        {
            $.ajax({
                url: 'ResourceService.asmx/GetAllResources',
                method: 'post',
                dataType: 'json',
                success: function (data) {
                    $('#resourcestable').dataTable({
                        data: data,
                        columns: [
                            { 'data': 'ResourceId' },
                            { 'data': 'ResourceName' },
                        ]
                    });
                }
            });
        }
    </script>

    <div class="jumbotron">
        <h1>Forecasting Tool</h1>
        <p class="lead">This tool helps you to see current resource utilization and also forecast utilization depending upon the availability of resources.</p>
        <p><a href="Contact.aspx" class="btn btn-primary btn-lg">Go To Utilization &raquo;</a></p>
    </div>

    <div style="width: 600px; border: 1px solid black; padding: 5px">
        <table id="resourcestable">
            <thead>
                <tr>
                    <th>S.No</th>
                    <th>Resource Name</th>
                </tr>
            </thead>
        </table>
    </div>

    <br />
    <br />
    <br />

    <div class="row">
        <div class="col-md-12">
            <div class="frm">
                <div class="form-group">
                    <label for="name" class="col-lg-2">Enter Resource Name</label>
                    <div class="col-lg-3">
                        <input type="text" class="form-control" name="name" id="name">
                    </div>
                    <div class="col-lg-4">
                        <button id="addResBtn" class="btn btn-primary btn-md">Add Resource &raquo;</button>
                    </div>
                </div>
            </div>
        </div>
    </div>

</asp:Content>

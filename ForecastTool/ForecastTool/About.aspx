<%@ Page Title="About" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="About.aspx.cs" Inherits="ForecastTool.About" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <script src="Scripts/jquery-1.10.2.js"></script>
    <link href="https://code.jquery.com/ui/1.10.4/themes/ui-lightness/jquery-ui.css" rel="stylesheet">
    <script src="https://code.jquery.com/jquery-1.10.2.js"></script>
    <script src="https://code.jquery.com/ui/1.10.4/jquery-ui.js"></script>
    <link rel="stylesheet" type="text/css" href="//cdn.datatables.net/1.10.16/css/jquery.dataTables.min.css" />
    <script type="text/javascript" src="//cdn.datatables.net/1.10.16/js/jquery.dataTables.min.js"></script>
    <script type="text/javascript">
        var table;
        $(document).ready(function () {

            $('#saveBtn').click(function (e) {
                saveClick();
            });

            $('#saveDiv').hide();

            $('#loadAttendanceBtn').click(function (e) {
                loadClick();
                e.preventDefault();
            });

            $('#selectedDate').datepicker({
                changeMonth: true,
                changeYear: true
            });
        });


        function loadClick() {
            var selectedDate = {}
            selectedDate.date = $('#selectedDate').val();

            if (new Date(selectedDate.date).setHours(0, 0, 0, 0) < new Date().setHours(0, 0, 0, 0)) {
                $('#saveDiv').hide();

                $.ajax({
                    url: 'AttendanceService.asmx/GetAttendanceForDate',
                    method: 'post',
                    contentType: 'application/json;charset=utf-8',
                    datatype: 'json',
                    data: '{selDate:' + JSON.stringify(selectedDate) + '}',
                    success: function (data) {
                        if ($.fn.DataTable.isDataTable("#attendanceTable")) {
                            $('#attendanceTable').DataTable().clear().destroy();
                        }
                        table = $('#attendanceTable').dataTable({
                            "data": data,
                            "columns": [
                                { 'data': 'ResourceId' },
                                { 'data': 'ResourceName' },
                                { 'data': 'AvailableHours' },
                            ]
                        });
                    }
                });
            }
            else {
                $('#saveDiv').show();

                $.ajax({
                    url: 'AttendanceService.asmx/GetFutureAttendance',
                    method: 'post',
                    contentType: 'application/json;charset=utf-8',
                    datatype: 'json',
                    data: '{selDate:' + JSON.stringify(selectedDate) + '}',
                    success: function (data) {
                        if ($.fn.DataTable.isDataTable("#attendanceTable")) {
                            $('#attendanceTable').DataTable().clear().destroy();
                        }
                        table = $('#attendanceTable').dataTable({
                            "data": data,
                            "columns": [
                                { 'data': 'ResourceId' },
                                { 'data': 'ResourceName' },
                                {
                                    'data': 'AvailableHours',
                                    render: function (data, type, row) {
                                        return '<input class="form-control" id="availableHourText" name="availableHourText" type="text"  value = ' + data + '  >';
                                    }
                                },
                            ]
                        });
                    }
                });
            }
        }

        function saveClick() {
            
                // You can use `jQuery(this).` to access each row, and process it further.
                console.log(table);
          
        }
    </script>

    <h2>Attendance</h2>
    <div class="row">
        <div class="col-md-12">
                    <label for="name" class="col-lg-2">Select Date:</label>
                    <div class="col-lg-3">
                        <input type="text" class="form-control" name="selectedDate" id="selectedDate">
                    </div>
                    <div class="col-lg-4">
                        <button type="button" id="loadAttendanceBtn" class="btn btn-primary btn-md";>Load &raquo;</button>
                    </div>
                </div>
        </div>

    <br />
    <div style="width: 600px; border: 1px solid black; padding: 5px">
        <table id="attendanceTable">
            <thead>
                <tr>
                    <th>Resource Id</th>
                    <th>Resource Name</th>
                    <th>Available Hours</th>
                </tr>
            </thead>
        </table>
    </div>

    <br />
    <div id="saveDiv">
       <button type="button" id="saveBtn" class="btn btn-primary btn-md";>Save &raquo;</button>
    </div>
</asp:Content>

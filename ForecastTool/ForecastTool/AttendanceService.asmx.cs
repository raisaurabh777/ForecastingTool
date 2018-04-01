using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.Script.Serialization;
using ForecastTool.Models;
using System.Web.Script.Services;

namespace ForecastTool
{
    /// <summary>
    /// Summary description for AttendanceService
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
    [System.Web.Script.Services.ScriptService]
    public class AttendanceService : System.Web.Services.WebService
    {

        [WebMethod]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public List<AttendanceRecord> GetAttendanceForDate(DateModel selDate)
        {
            try
            {
                string cs = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
                var attendanceRecords = new List<AttendanceRecord>();
                using (SqlConnection con = new SqlConnection(cs))
                {
                    SqlCommand cmd = new SqlCommand("GetAttendanceDetails", con);
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.Add(new SqlParameter()
                    {
                        ParameterName = "@SelectedDate",
                        Value = selDate.date
                    });
                    con.Open();
                    SqlDataReader rdr = cmd.ExecuteReader();
                    while (rdr.Read())
                    {
                        AttendanceRecord record = new AttendanceRecord();
                        record.ResourceId = Convert.ToInt32(rdr["ResourceId"]);
                        record.ResourceName = rdr["ResourceName"].ToString();
                        record.AvailableHours = Convert.ToInt32(rdr["AvailableHours"]);
                        attendanceRecords.Add(record);
                    }

                    return attendanceRecords;
                }
            }
            catch (Exception ex)
            {

                throw;
            }
        }

        [WebMethod]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public List<AttendanceRecord> GetFutureAttendance(DateModel selDate)
        {
            try
            {
                string cs = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
                var attendanceRecords = new List<AttendanceRecord>();
                using (SqlConnection con = new SqlConnection(cs))
                {
                    SqlCommand cmd = new SqlCommand("GetFutureAttendance", con);
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.Add(new SqlParameter()
                    {
                        ParameterName = "@SelectedDate",
                        Value = selDate.date
                    });
                    con.Open();
                    SqlDataReader rdr = cmd.ExecuteReader();
                    while (rdr.Read())
                    {
                        AttendanceRecord record = new AttendanceRecord();
                        record.ResourceId = Convert.ToInt32(rdr["ResourceId"]);
                        record.ResourceName = rdr["ResourceName"].ToString();
                        record.AvailableHours = Convert.ToInt32(rdr["AvailableHours"]);
                        attendanceRecords.Add(record);
                    }

                    return attendanceRecords;
                }
            }
            catch (Exception ex)
            {

                throw; 
            }
        }


    }
}

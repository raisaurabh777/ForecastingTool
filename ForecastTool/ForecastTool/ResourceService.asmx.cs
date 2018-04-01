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

namespace ForecastTool
{
    /// <summary>
    /// Summary description for ResourceService
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
    [System.Web.Script.Services.ScriptService]
    public class ResourceService : System.Web.Services.WebService
    {

        [WebMethod]
        public void GetAllResources()
        {
            try
            {
                string cs = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
                List<Resource> persons = new List<Models.Resource>();
                using (SqlConnection con = new SqlConnection(cs))
                {
                    SqlCommand cmd = new SqlCommand("GetAllResources", con);
                    cmd.CommandType = CommandType.StoredProcedure;
                    con.Open();
                    SqlDataReader rdr = cmd.ExecuteReader();
                    while (rdr.Read())
                    {
                        Resource person = new Resource();
                        person.ResourceId = Convert.ToInt32(rdr["S.No"]);
                        person.ResourceName = rdr["ResourceName"].ToString();
                        persons.Add(person);
                    }
                }

                JavaScriptSerializer js = new JavaScriptSerializer();
                Context.Response.Write(js.Serialize(persons));
            }
            catch (Exception ex)
            {

                throw;
            }
        }

        [WebMethod]
        public void InsertResource(Resource res)
        {
            try
            {
                string cs = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
                using (SqlConnection con = new SqlConnection(cs))
                {
                    SqlCommand cmd = new SqlCommand("InsertResource", con);
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.Add(new SqlParameter()
                    {
                        ParameterName = "@ResourceName",
                        Value = res.ResourceName
                    });
                    con.Open();
                    cmd.ExecuteNonQuery();
                }
            }
            catch (Exception ex)
            {

                throw;
            }
        }
    }
}

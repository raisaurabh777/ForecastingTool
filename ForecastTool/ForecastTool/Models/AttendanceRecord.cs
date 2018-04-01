using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace ForecastTool.Models
{
    public class AttendanceRecord
    {
        protected internal AttendanceRecord()
        {

        }

        public int ResourceId { get; set; }
        public string ResourceName { get; set; }
        public int AvailableHours { get; set; }
    }
}
using System;
using System.Collections.Generic;

namespace manage.Models
{
    public partial class Report
    {
        public int IdReport { get; set; }
        public int IdReportCreator { get; set; }
        public string ReportContent { get; set; }
        public DateTime ReportDate { get; set; }

        public Employee IdReportCreatorNavigation { get; set; }
    }
}

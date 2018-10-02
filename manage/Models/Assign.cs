using System;
using System.Collections.Generic;

namespace manage.Models
{
    public partial class Assign
    {
        public int IdCreator { get; set; }
        public int IdAssignee { get; set; }
        public int IdTask { get; set; }

        public Employee IdAssigneeNavigation { get; set; }
        public Employee IdCreatorNavigation { get; set; }
        public Task IdTaskNavigation { get; set; }
    }
}

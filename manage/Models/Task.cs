using System;
using System.Collections.Generic;

namespace manage.Models
{
    public partial class Task
    {
        public Task()
        {
            Assign = new HashSet<Assign>();
        }

        public int IdTask { get; set; }
        public string TaskDescription { get; set; }
        public DateTime AssignDate { get; set; }
        public DateTime DueDate { get; set; }

        public ICollection<Assign> Assign { get; set; }
    }
}

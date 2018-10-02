using System;
using System.Collections.Generic;

namespace manage.Models
{
    public partial class Employee
    {
        public Employee()
        {
            AssignIdAssigneeNavigation = new HashSet<Assign>();
            AssignIdCreatorNavigation = new HashSet<Assign>();
            ManageIdManagedNavigation = new HashSet<Manage>();
            ManageIdManagerNavigation = new HashSet<Manage>();
            Report = new HashSet<Report>();
        }

        public int IdEmployee { get; set; }
        public string FirstName { get; set; }
        public string LastName { get; set; }
        public string Position { get; set; }
        public byte[] Picture { get; set; }

        public ICollection<Assign> AssignIdAssigneeNavigation { get; set; }
        public ICollection<Assign> AssignIdCreatorNavigation { get; set; }
        public ICollection<Manage> ManageIdManagedNavigation { get; set; }
        public ICollection<Manage> ManageIdManagerNavigation { get; set; }
        public ICollection<Report> Report { get; set; }
    }
}

using System;
using System.Collections.Generic;
using System.Linq;

namespace manage.Models
{
    public partial class Manage
    {
        public int IdManager { get; set; }
        public int IdManaged { get; set; }

        public Employee IdManagedNavigation { get; set; }
        public Employee IdManagerNavigation { get; set; }

        //private readonly List<int> getManagerByEmployee;

        public List<Manage> GetManagerByEmployee(Employee employee)
        {
            exerciseContext db = new exerciseContext();
            //var getManagerByEmployee = context.Manage.Find(employee.IdEmployee);

            var manager = from manage in db.Manage where manage.IdManager.Equals(employee.IdEmployee) select manage;

            //var manager = db.Manage.Where()


            return manager.ToList();

        }

        public List<int> GetManagedByEmployee { get; }
    }
}

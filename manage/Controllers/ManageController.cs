using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using manage.Models;
using Microsoft.AspNetCore.Mvc;
using ReactCrudDemo.Models;
using static ReactCrudDemo.Models.ManageDataAccessLayer;

// For more information on enabling Web API for empty projects, visit https://go.microsoft.com/fwlink/?LinkID=397860

namespace ReactCrudDemo.Controllers
{
    public class ManageController : Controller
    {
        ManageDataAccessLayer objManage = new ManageDataAccessLayer();

        [HttpGet]
        [Route("api/Employee/Index")]
        public List<Employee> Index()
        {
            return objManage.GetAllEmployees();
        }

        [HttpPost]
        [Route("api/Employee/Create")]
        public int Create(Employee employee)
        {
            return objManage.AddEmployee(employee);
        }

        [HttpGet]
        [Route("api/Employee/Details/{id}")]
        public EmployeeResult Details(int id)
        {
            var detailsResult = new EmployeeResult();
            detailsResult.employee = objManage.GetEmployeeData(id);
            var managerOf = objManage.GetManagerOf(id);
            detailsResult.managerOf = managerOf;
            detailsResult.managedBy = objManage.GetMyManager(id);
            detailsResult.taskList = objManage.GetMyTasks(id);
            detailsResult.reportList = objManage.GetMyReports(managerOf);
            return detailsResult;
        }

        [HttpPost]
        [Route("api/Employee/Report")]
        public List<Report> CreateReport([FromBody] Report report)
        {
            if (1==objManage.CreateReport(report))
            {
                return objManage.GetAllReports();
            }
            else
            {
                var emptyList = new List<Report>();
                return emptyList;

            }
        }

        [HttpPost]
        [Route("api/Employee/Task")]
        public List<manage.Models.Task> CreateTask([FromBody] TaskObjectFromClient task)
        {
            if (1 == objManage.CreateTask(task))
            {
                return objManage.GetAllTasks();
            }
            else
            {
                var emptyList = new List<manage.Models.Task>();
                return emptyList;

            }
        }

        [HttpPut]
        [Route("api/Employee/Edit")]
        public int Edit(Employee employee)
        {
            return objManage.UpdateEmployee(employee);
        }

        [HttpDelete]
        [Route("api/Employee/Delete/{id}")]
        public int Delete(int id)
        {
            return objManage.DeleteEmployee(id);
        }
    }
}

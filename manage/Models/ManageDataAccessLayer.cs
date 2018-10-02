using manage.Models;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace ReactCrudDemo.Models
{
    public class ManageDataAccessLayer
    {
        exerciseContext db = new exerciseContext();

        public List<Employee> GetAllEmployees()
        {
            try
            {
                List <Employee> result = new List<Employee>();
                var employees = db.Employee.ToList();
                
                return employees.ToList();
            }
            catch
            {
                throw;
            }
        }

        //To Add new employee record   
        public int AddEmployee(Employee employee)
        {
            try
            {
                db.Employee.Add(employee);
                db.SaveChanges();
                return 1;
            }
            catch
            {
                throw;
            }
        }

        //To Update the records of a particluar employee  
        public int UpdateEmployee(Employee employee)
        {
            try
            {
                db.Entry(employee).State = EntityState.Modified;
                db.SaveChanges();

                return 1;
            }
            catch
            {
                throw;
            }
        }

        public struct EmployeeResult
        {
            public Employee employee { get; set; }
            public List<Employee> managerOf { get; set; }
            public Employee managedBy { get; set; }
            public List<manage.Models.Task> taskList { get; set; }
            public List<Report> reportList { get; set; }
        }

        //Get the details of a particular employee  
        public Employee GetEmployeeData(int id)
        {
            try
            {
                EmployeeResult result = new EmployeeResult ();

                Employee employee = db.Employee.Find(id);
                return employee;
            }
            catch
            {
                throw;
            }
        }

        public List<Employee> GetManagerOf (int idEmployee)
        {
            try
            {
                var managers = from manage in db.Manage where manage.IdManager.Equals(idEmployee) select manage;
                var managersList = new List<Employee>();
                foreach (Manage manageObj in managers)
                {
                    managersList.Add(this.GetEmployeeData(manageObj.IdManaged));
                }
                return managersList;
            }
            catch
            {
                throw;
            }
        }

        public Employee GetMyManager(int idEmployee)
        {
            try
            {
                var managed = from manage in db.Manage where manage.IdManaged.Equals(idEmployee) select manage;

                var managedList = new List<Employee>();
                foreach (Manage manageObject in managed)
                {
                    managedList.Add(this.GetEmployeeData(manageObject.IdManager));
                    break;
                }
                return managedList.FirstOrDefault();

            }
            catch
            {
                throw;
            }
        }

        public List<manage.Models.Task> GetMyTasks(int idEmployee)
        {
            try
            {
                var assignedTasks = from Assign in db.Assign where Assign.IdAssignee.Equals(idEmployee) select Assign;

                var assignedTaskList = new List<manage.Models.Task>();
                foreach (Assign assignObject in assignedTasks)
                {
                    assignedTaskList.Add(db.Task.Find(assignObject.IdTask));
                }
                return assignedTaskList;

            }
            catch
            {
                throw;
            }
        }

        
        //To Delete the record of a particular employee  
        public int DeleteEmployee(int id)
        {
            try
            {
                Employee emp = db.Employee.Find(id);
                db.Employee.Remove(emp);
                db.SaveChanges();
                return 1;
            }
            catch
            {
                throw;
            }
        }

        //To create new report 
        public int CreateReport(Report CreateReport)
        {
            try
            {
                Report report = new Report();

                report.IdReport = 0;
                report.IdReportCreator = CreateReport.IdReportCreator;
                report.ReportContent = CreateReport.ReportContent;
                report.ReportDate = DateTime.Now;
               
                db.Report.Add(report);
                db.SaveChanges();
                return 1;
            }
            catch
            {
                throw;
            }
        }

        public List<Report> GetAllReports ()
        {
            try
            {
                return db.Report.ToList();
            }
            catch
            {
                throw;
            }
        }

        public List<Report> GetMyReports(List<Employee> employees)
        {
            try
            {
                var listOfIds = new List<int>();
                foreach (Employee employee in employees)
                {
                    listOfIds.Add(employee.IdEmployee);
                }

                var reports = from Report in db.Report where listOfIds.Contains(Report.IdReportCreator) select Report;
                return reports.ToList();
            }
            catch
            {
                throw;
            }
        }

        public struct TaskObjectFromClient
        {
            public int IdTaskCreator { get; set; }
            public int TaskAssignee { get; set; }
            public string TaskDescription { get; set; }
            public DateTime DueDate { get; set; }
        }

        //To create new task 
        public int CreateTask(TaskObjectFromClient CreateTask)
        {
            try
            {
                manage.Models.Task task = new manage.Models.Task();

                task.IdTask = 0;
                task.TaskDescription = CreateTask.TaskDescription;
                task.AssignDate = DateTime.Now;
                task.DueDate = CreateTask.DueDate;

                db.Task.Add(task);
                db.SaveChanges();

                Assign assign = new Assign();
                assign.IdCreator = CreateTask.IdTaskCreator;
                assign.IdAssignee = CreateTask.TaskAssignee;
                assign.IdTask = task.IdTask;

                db.Assign.Add(assign);
                db.SaveChanges();
                return 1;
            }
            catch
            {
                throw;
            }
        }

        public List<manage.Models.Task> GetAllTasks()
        {
            try
            {
                return db.Task.ToList();
            }
            catch
            {
                throw;
            }
        }
    }
}

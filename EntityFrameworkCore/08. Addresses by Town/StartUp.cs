using Microsoft.EntityFrameworkCore;
using SoftUni.Data;
using SoftUni.Models;
using System;
using System.Globalization;
using System.Linq;
using System.Text;
using System.Threading;

namespace SoftUni
{
    public class StartUp
    {
        static void Main(string[] args)
        {
            Thread.CurrentThread.CurrentCulture = new CultureInfo("en-US");
            SoftUniContext context = new SoftUniContext();


            var res = GetAddressesByTown(context);
            Console.WriteLine(res);
        }

        // 3
        public static string GetEmployeesFullInformation(SoftUniContext context)
        {
            StringBuilder sb = new StringBuilder();
            var allEmployees = context
                .Employees
                .OrderBy(e => e.EmployeeId)
                .Select( e => new
                { 
                    e.FirstName,
                    e.LastName,
                    e.MiddleName,
                    e.JobTitle,
                    e.Salary
                })
                .ToArray();
            foreach (var e in allEmployees)
            {
                sb.AppendLine($"{e.FirstName} {e.LastName} {e.MiddleName} {e.JobTitle} {e.Salary:f2}");
            }
            return sb.ToString();
        }
        // 4
        public static string GetEmployeesWithSalaryOver50000(SoftUniContext context)
        {
            StringBuilder sb = new StringBuilder();

            var employees = context
                .Employees
                .OrderBy(e => e.FirstName)
                .Where(e => e.Salary > 50000)
                .ToArray();
            foreach (var e in employees)
            {
                sb.AppendLine($"{e.FirstName} - {e.Salary:f2}");
            }
            return sb.ToString().TrimEnd();

        }
        // 5
        public static string GetEmployeesFromResearchAndDevelopment(SoftUniContext context)
        {
            StringBuilder sb = new StringBuilder();

            var employees = context
                .Employees
                .OrderBy(e => e.Salary)
                .ThenByDescending(e => e.FirstName)
                .Where(e => e.Department.Name == "Research and Development")
                .ToArray();
            foreach (var e in employees)
            {
                sb.AppendLine($"{e.FirstName} {e.LastName} from Research and Development - ${e.Salary:f2}");
            }
            return sb.ToString().TrimEnd();
        }
        // 6
        public static string AddNewAddressToEmployee(SoftUniContext context)
        { 
            Address address = new Address();
            address.AddressText = "Vitoshka 15";
            address.TownId = 4;
            Employee nakov = context
                .Employees
                .First(e => e.LastName == "Nakov");
                
            nakov.Address = address;
            context.SaveChanges();

            var adrText = context
                .Employees
                .Select( e => new { 
                    e.AddressId,
                    e.Address
                })
                .OrderByDescending(e => e.AddressId)
                .Take(10)
                .ToArray();
            StringBuilder sb = new StringBuilder();
            foreach (var e in adrText)
            {
                sb.AppendLine($"{e.Address.AddressText}");
            }
            return sb.ToString().TrimEnd();
        }
        // 7
        public static string GetEmployeesInPeriod(SoftUniContext context)
        {
            StringBuilder sb = new StringBuilder();
            var employees = context
                .Employees
                .Where(e => e.EmployeesProjects.Any(ep => ep.Project.StartDate.Year > 2001
                && ep.Project.StartDate.Year < 2003))
                .Take(10)
                .Select(e => new
                {
                    e.FirstName,
                    e.LastName,
                    ManagerFirstName = e.Manager.FirstName,
                    ManagerLastName = e.Manager.LastName,
                    AllProjects = e.EmployeesProjects
                        .Select(ep => new
                        {
                            ProjectName = ep.Project.Name,
                            StartDate = ep.Project
                                        .StartDate
                                        .ToString("M/d/yyyy h:mm:ss tt"),
                            EndDate = ep.Project
                                        .EndDate
                                        .HasValue ?
                                        ep.Project.EndDate.Value.ToString("M/d/yyyy h:mm:ss tt") : "not finished"
                        })
                })
                .ToArray();
            foreach (var e in employees)
            {
                sb.AppendLine($"{e.FirstName} {e.LastName} - Manager: {e.ManagerFirstName} {e.ManagerLastName}");
                foreach (var p in e.AllProjects)
                {
                    sb.AppendLine($"--{p.ProjectName} - {p.StartDate} - {p.EndDate} ");
                }
            }
            return sb.ToString().TrimEnd();




        }
        // 8
        public static string GetAddressesByTown(SoftUniContext context)
        { 
            StringBuilder sb = new StringBuilder();
            var addresses = context
                .Addresses
                .Select(b => new
                {
                   b.AddressText,
                    b.Town.Name,
                    b.Employees.Count
                })
                .OrderByDescending(a => a.Count)
                .ThenBy(a => a.Name)
                .ThenBy(a => a.AddressText)
                .Take(10)
               .ToArray();

            foreach (var a in addresses)
            {
              sb.AppendLine($"{a.AddressText}, {a.Name} - {a.Count} employees");
            }
            return sb.ToString().TrimEnd();
        }
        // 9
        public static string GetEmployee147(SoftUniContext context)
        { 
            StringBuilder sb = new StringBuilder();
            var e147 = context
                .Employees
                .Find(147);
            var projs = context
                .EmployeesProjects
                .Include(p => p.Project)
                .Where(a => a.EmployeeId == 147)
                .OrderBy(p => p.Project.Name)
                .ToArray();
            sb.AppendLine($"{e147.FirstName} {e147.LastName} - {e147.JobTitle}");
            foreach (var e in projs)
            {
                sb.AppendLine($"{e.Project.Name}");
            }
            return sb.ToString().TrimEnd();
        }
        // 10
        public static string GetDepartmentsWithMoreThan5Employees(SoftUniContext context)
        {
            StringBuilder sb = new StringBuilder();



            return sb.ToString().TrimEnd();
        }

    }
}

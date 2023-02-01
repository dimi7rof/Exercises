using Microsoft.EntityFrameworkCore;
using SoftUni.Data;
using SoftUni.Models;
using System;
using System.Collections.Generic;
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


            var res = RemoveTown(context);
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
        // 7 no
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
        // 10 no
        public static string GetDepartmentsWithMoreThan5Employees(SoftUniContext context)
        {
            StringBuilder sb = new StringBuilder();
            var depts = context
                .Departments
                .Where(x => x.Employees.Count > 5)
                .Select(x => new
                {
                    x.Name,
                    x.Manager.FirstName,
                    x.Manager.LastName,
                    Employees = x.Employees
                        .Select(e => new
                        {
                            e.FirstName,
                            e.LastName,
                            e.JobTitle
                        })
                    .OrderBy(x => x.FirstName)
                    .ThenBy(x => x.LastName)
                    .ToList()
                })
                .OrderBy(x => x.Employees.Count)
                .ThenBy(x => x.Name)
                .ToArray();
            foreach (var d in depts)
            {
                sb.AppendLine($"{d.Name} - {d.FirstName} {d.LastName}");
                foreach (var e in d.Employees)
                {
                    sb.AppendLine($"{e.FirstName} {e.LastName} - {e.JobTitle}");
                }
            }

            return sb.ToString().TrimEnd();
        }
        // 11
        public static string GetLatestProjects(SoftUniContext context)
        {
            StringBuilder sb = new StringBuilder();
            var proj = context
                .Projects
                .OrderByDescending(x => x.StartDate)
                .Take(10)
                .ToArray();
            foreach (var p in proj.OrderBy(x => x.Name))
            {
                sb.AppendLine($"{p.Name}");
                sb.AppendLine($"{p.Description}");
                sb.AppendLine($"{p.StartDate.ToString("M/d/yyyy h:mm:ss tt")}");
            }

            return sb.ToString().TrimEnd();
        }
        // 12 
        public static string IncreaseSalaries(SoftUniContext context)
        {
            StringBuilder sb = new StringBuilder();
            var emp = context
                .Employees
                .Where(x => x.Department.Name == "Engineering" ||
                            x.Department.Name == "Tool Design" ||
                            x.Department.Name == "Marketing" ||
                            x.Department.Name == "Information Services")
                .ToArray();
            foreach (var e in emp)
            {
                decimal sal = e.Salary;
                e.Salary = sal * (decimal)1.12;
            }
            context.SaveChanges();
            foreach (var e in emp.OrderBy(e => e.FirstName).ThenBy(e => e.LastName))
            {
                sb.AppendLine($"{e.FirstName} {e.LastName} (${e.Salary:f2})");
            }
            return sb.ToString().TrimEnd();
        }
        // 13
        public static string GetEmployeesByFirstNameStartingWithSa(SoftUniContext context)
        {
            StringBuilder sb = new StringBuilder();
            var emp = context
               .Employees
               .Where(x => "Sa" == x.FirstName.Substring(0,2))
               .ToArray();
            foreach (var e in emp.OrderBy(e => e.FirstName).ThenBy(e => e.LastName))
            {
                sb.AppendLine($"{e.FirstName} {e.LastName} - {e.JobTitle} - (${e.Salary:f2})");
            }
            return sb.ToString().TrimEnd();
        }
        // 14
        public static string DeleteProjectById(SoftUniContext context)
        {
            StringBuilder sb = new StringBuilder();
            var project = context.Projects.Find(2);
            var epToDel = context
                .EmployeesProjects
                .Where(x => x.ProjectId == 2)
                .ToArray();
            context.EmployeesProjects.RemoveRange(epToDel);
            context.Projects.Remove(project);
            context.SaveChanges();
            var pToDisplay = context
                .Projects
                .Take(10)
                .ToArray();

            foreach (var p in pToDisplay)
            {
                sb.AppendLine($"{p.Name}");
            }

            return sb.ToString().TrimEnd();
        }
        // 15
        public static string RemoveTown(SoftUniContext context)
        {
            StringBuilder sb = new StringBuilder();

            Town town = context.Towns
                .FirstOrDefault(x => x.Name == "Seattle");

            Address[] adrToDel = context
                .Addresses
                .Where(x => x.TownId == town.TownId)
                .ToArray();

            Employee[] empAdrToDel = context
                 .Employees
                 .Include(a => a.Address)
                 .ThenInclude(a => a.Town)
                 .Where(x => x.Address.TownId == town.TownId)
                 .ToArray();

            int countAdr = adrToDel.Length;

            foreach (var e in empAdrToDel)
            {
                e.AddressId = null;
            }
            context.Addresses.RemoveRange(adrToDel);
            context.Towns.Remove(town);
            context.SaveChanges();

            sb.AppendLine($"{countAdr} addresses in Seattle were deleted");

            return sb.ToString().TrimEnd();
        }
    }
}

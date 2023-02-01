using SoftUni.Data;
using SoftUni.Models;
using System;
using System.Linq;
using System.Text;

namespace SoftUni
{
    public class StartUp
    {
        static void Main(string[] args)
        {
            SoftUniContext context = new SoftUniContext();


            var res = AddNewAddressToEmployee(context);
            Console.WriteLine(res);
        }


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
    }
}

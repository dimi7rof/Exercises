using SoftUni.Data;
using System;
using System.Linq;
using System.Text;

namespace SoftUni
{
    internal class StartUp
    {
        static void Main(string[] args)
        {
            SoftUniContext context = new SoftUniContext();


            var res = GetEmployeesFullInformation(context);
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
                    e.JobTitle,
                    e.Salary
                })
                .ToArray();
            foreach (var e in allEmployees)
            {
                sb.AppendLine($"{e.FirstName} {e.LastName} {e.JobTitle} {e.Salary:f2}");
            }
            return sb.ToString();
        }
    }
}

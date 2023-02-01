using System;
using System.Collections.Generic;
using System.Linq;

namespace BorderControl
{
    public class Program
    {
        static void Main(string[] args)
        {
            List<string> list = new List<string>();
            string input = Console.ReadLine();
            while (input != "End")
            {
                string[] parts = input.Split(' ', StringSplitOptions.RemoveEmptyEntries);
                string year = parts[parts.Length - 1];
                if (year.Contains('/')) list.Add(year);
                input = Console.ReadLine();
            }
            string output = Console.ReadLine();
            bool exist = false;
            foreach (var item in list)
            {
                if (item.EndsWith(output))
                {
                        Console.WriteLine(item);
                        exist = true;
                }
            }
            if (!exist) Console.WriteLine("<empty output>");
        }
    }
}

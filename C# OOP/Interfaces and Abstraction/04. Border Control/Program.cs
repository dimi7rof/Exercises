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
                string[] parts = input.Split();
                list.Add(parts[parts.Length -1]);
                input = Console.ReadLine();
            }
            string output = Console.ReadLine();
            Console.WriteLine(string.Join("\n", list.Where(x => x.EndsWith(output))));
        }
    }
}

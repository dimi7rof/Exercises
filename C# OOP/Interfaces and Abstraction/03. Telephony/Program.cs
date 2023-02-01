using System;
using System.Collections.Generic;
using System.Linq;

namespace OOP
{
    public  class Program
    {
        static void Main(string[] args)
        {
            List<string> numbers = Console.ReadLine().Split().ToList();
            List<string> urls = Console.ReadLine().Split().ToList();
            
            foreach (var num in numbers)
            {
                bool invalid = false;
                foreach (var charr in num) 
                {
                    if (!char.IsDigit(charr))
                    {
                        invalid = true;
                        break;
                    }
                }
                if (invalid) Console.WriteLine("Invalid number!");
               else if (num.Length > 7) Console.WriteLine($"Calling... {num}");
                else  Console.WriteLine($"Dialing... {num}");
            }
            foreach (var url in urls)
            {
                bool invalid = false;
                foreach (var charr in url)
                {
                    if (char.IsDigit(charr))
                    {
                        invalid = true;
                        break;
                    }
                }
                if (invalid) Console.WriteLine("Invalid URL!");
               else Console.WriteLine($"Browsing: {url}!");
            }


        }
    }
}

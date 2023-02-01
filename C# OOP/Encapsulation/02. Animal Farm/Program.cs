namespace AnimalFarm
{
    using System;
    using AnimalFarm.Models;
   public class Program
    {
        static void Main(string[] args)
        {
            string name = Console.ReadLine();
            int age = int.Parse(Console.ReadLine());
            try
            {
            if (age <= 0)
            {
                throw new ArgumentException("Age should be between 0 and 15.");
            }
            if (age > 15)
            {
                throw new ArgumentException("Age should be between 0 and 15.");
            }
                if (string.IsNullOrWhiteSpace(name))
                {
                    throw new ArgumentException("Name cannot be empty.");
                }
                Chicken chicken = new Chicken(name, age);
                Console.WriteLine(
                    "Chicken {0} (age {1}) can produce {2} eggs per day.",
                    chicken.Name,
                    chicken.Age,
                    chicken.ProductPerDay);
            }
            catch (Exception ex)
            {

                Console.WriteLine(ex.Message);
            }
        }
    }
}

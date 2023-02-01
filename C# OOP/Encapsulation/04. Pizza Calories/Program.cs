using System;
using System.Collections.Generic;

namespace Pizza
{
    public class Program
    {
        static void Main(string[] args)
        {
            Dictionary<string, double> modifiers = new Dictionary<string, double>()
        {
            {"meat", 1.2 },
            {"veggies", 0.8 },
            {"cheese", 1.1 },
            {"sauce", 0.9 },
        };
            Dictionary<string, double> modifiers2 = new Dictionary<string, double>()
        {
            { "white", 1.5},
            { "wholegrain", 1.0},
            { "crispy", 0.9},
            { "chewy", 1.1},
            { "homemade", 1.0}
        };
            try
            {
                string[] pizzaIn = Console.ReadLine().Split();
                string pizzaName = pizzaIn[1];
                Pizza pizza = new Pizza(pizzaName);
                if (string.IsNullOrEmpty(pizzaName))
                {
                    throw new ArgumentException("Pizza name should be between 1 and 15 symbols.");
                }
                if (pizzaName.Length > 15)
                {
                    throw new ArgumentException("Pizza name should be between 1 and 15 symbols.");
                }

                string[] doughInp = Console.ReadLine().Split();
                string doughInput = doughInp[0];
                string type = doughInp[1].ToLower();
                if (!modifiers2.ContainsKey(type))
                {
                    throw new ArgumentException("Invalid type of dough.");

                }
                string baking = doughInp[2].ToLower();
                if (!modifiers2.ContainsKey(baking))
                {
                    throw new ArgumentException("Invalid type of dough.");
                }
                double weight = double.Parse(doughInp[3]);
                if (weight < 1 || weight > 200)
                {
                    throw new ArgumentException("Dough weight should be in the range [1..200].");
                }

                Dough dough = new Dough(type, baking, weight);
                double totalCalories = dough.Calories;
                int topiingCount = 0;
                string[] topInput = Console.ReadLine().Split();
                while (topInput[0] != "END")
                {
                    topiingCount++;
                    string toppingInp = topInput[0].ToLower();
                    string topppingType = topInput[1].ToLower();
                    double topWeight = double.Parse(topInput[2]);

                    if (topWeight < 1 || topWeight > 50)
                    {
                        throw new ArgumentException($"{topInput[1]} weight should be in the range [1..50].");

                    }
                    if (!modifiers.ContainsKey(topppingType))
                    {
                        throw new ArgumentException($"Cannot place {topInput[1]} on top of your pizza.");
                    }
                    Topping topping = new Topping(topppingType, topWeight);
                    double topCalories = topping.Calories;
                    totalCalories += topCalories;
                    if (topiingCount > 10)
                    {
                        throw new ArgumentException("Number of toppings should be in range [0..10].");

                    }
                    topInput = Console.ReadLine().Split();
                }

                Console.WriteLine($"{pizzaName} - {totalCalories:f2} Calories.");
            }
            catch (Exception ex)
            {

                Console.WriteLine(ex.Message);
            }

        }
    }
}

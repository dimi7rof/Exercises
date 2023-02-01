using System;
using System.Collections.Generic;
using System.Text;

namespace Pizza
{
    public class Topping
    {
       public Dictionary<string, double> modifiers = new Dictionary<string, double>()
        {
            {"meat", 1.2 },
            {"veggies", 0.8 },
            {"cheese", 1.1 },
            {"sauce", 0.9 },
        };
        private string  toppingType;
        private double weight;

        public Topping(string toppingType, double weight)
        {
            this.toppingType = toppingType;
            this.weight = weight;
        }

        public string  ToppingType
        {
            get { return toppingType; }
            set {
               
                toppingType = value; }
        }

        public double Weight
        {
            get { return weight; }
            set {
                
                weight = value; }
        }


        public double Calories
            => 2
            * Weight
            * modifiers[ToppingType];
    }
}

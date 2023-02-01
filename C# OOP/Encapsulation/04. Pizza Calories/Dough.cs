using System;
using System.Collections.Generic;
using System.Text;

namespace Pizza
{
    public class Dough
    {
        Dictionary<string, double> modifiers = new Dictionary<string, double>()
        {
            { "white", 1.5},
            { "wholegrain", 1.0},
            { "crispy", 0.9},
            { "chewy", 1.1},
            { "homemade", 1.0}
        };
        private string type;
        private string baking;
        private double weight;

        public Dough(string type, string baking, double weight)
        {
            this.type = type;
            this.baking = baking;
            this.weight = weight;
        }

        public string Type
        {
            get { return type; }
            set {
                
                type = value; }
        }

        public string Baking
        {
            get { return baking; }
            set {
               
                baking = value; }
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
            * modifiers[Type]
            * modifiers[Baking];


    }
}

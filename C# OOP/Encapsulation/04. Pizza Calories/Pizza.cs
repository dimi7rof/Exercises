using System;
using System.Collections.Generic;
using System.Text;

namespace Pizza
{
    public class Pizza
    {
        private string name;
        private Dough dough;
        private Topping topping;

        public Pizza(string name)
        {
            this.name = name;
        }

        public string Name
        {
            get { return name; }
            set {
                
                name = value; }
        }

        public Dough Dough
        {
            get { return dough; }
            set { dough = value; }
        }


        public Topping Topping
        {
            get { return topping; }
            set { topping = value; }
        }




    }
}

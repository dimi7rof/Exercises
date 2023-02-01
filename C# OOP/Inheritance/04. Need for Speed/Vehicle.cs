using System;
using System.Collections.Generic;
using System.Text;

namespace NeedForSpeed
{
   public class Vehicle
    {
        public Vehicle(int horsePower, double fuel)
        {
            HorsePower = horsePower;
            Fuel = fuel;
            
        }

        public int HorsePower { get; set; }
        public double Fuel { get; set; }
        public virtual double FuelConsumation { get; set; }
        public double DefaultFuelConsumption  { get; set; }
        public virtual void Drive(double kilometers)
        {
            this.Fuel -= kilometers * 1.25;
        
        }

    }
}

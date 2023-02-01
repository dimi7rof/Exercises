namespace CarManager.Tests
{
    using NUnit.Framework;
    using System;

    [TestFixture]
    public class CarManagerTests
    {

        [Test]
        [TestCase("make", "model", 5, 30)]

        public void Test_Constructor_Input_leght(string make, string model, double fc, double fk)
        {
            // Arrange
           Car car = new Car(make, model, fc, fk);
            // Assert
            Assert.AreEqual(
                car.Make, make);
            Assert.AreEqual(
                car.Model,  model);
            Assert.AreEqual(
                car.FuelConsumption, fc);
            Assert.AreEqual(
                car.FuelCapacity, fk);
            Assert.Throws<ArgumentException>(
                () => new Car("", "a", 1, 1));
            Assert.Throws<ArgumentException>(
                () => new Car(null, "a", 1, 1));
            Assert.Throws<ArgumentException>(
               () => new Car("a", null, 1, 1));
            Assert.Throws<ArgumentException>(
                () => new Car("a", "", 1, 1));
            Assert.Throws<ArgumentException>(
                () => new Car("a", "b", 1, 0));
            Assert.Throws<ArgumentException>(
                () => new Car("a", "b", 0, 1));
            Assert.Throws<ArgumentException>(
                () => car.Refuel(0));
           
            
           
           


        }
        [Test]
        public void Car_Refuel()
        {
            Car car = new Car("make", "model", 1, 30);
            Assert.Throws<InvalidOperationException>(
                () => car.Drive(100));
            Assert.AreEqual(
                0 , car.FuelAmount);
            car.Refuel(30);
            Assert.AreEqual(
                30, car.FuelAmount);
            car.Drive(100);

            Assert.AreEqual(
                29, car.FuelAmount);
        }
    }
}
namespace DatabaseExtended.Tests
{
    using ExtendedDatabase;
    using NUnit.Framework;
    using System;
    using System.Collections;
    using System.Collections.Generic;

    [TestFixture]
    public class ExtendedDatabaseTests
    {

        [Test]
        public void Constructor_test()
        {
            Database database = new Database(new Person(1, "Az"));
            Assert.AreEqual(database.Count, 1);
            database.Remove();
            Assert.AreEqual(database.Count, 0);
            Assert.Throws<InvalidOperationException>(
               () =>
               {
                   database.Remove();
               });
            for (int i = 0; i < 16; i++)
            {
                Person person = new Person(i, i.ToString());
                database.Add(person);
            }
            Assert.AreEqual(
                database.Count, 16
                );
            Assert.Throws<InvalidOperationException>(
                () => database.Add(new Person(17, "a")));
            database.Remove();
            Assert.Throws<InvalidOperationException>(
                () => database.Add(new Person(17, "1")));
            database.Remove();
            Assert.Throws<InvalidOperationException>(
                () => database.Add(new Person(1, "Az")));
            Assert.Throws<ArgumentOutOfRangeException>(
                () => database.FindById(-1));
            Assert.Throws<ArgumentNullException>(
                () => database.FindByUsername(""));
            Assert.Throws<InvalidOperationException>(
                () => database.FindByUsername("Gosh"));
        }
    }
}
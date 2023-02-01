namespace Database.Tests
{
    using NUnit.Framework;
    using System;

    [TestFixture]
    public class DatabaseTests
    {
        [Test]
        [TestCase(new int[] { 1})]
        [TestCase(new int[] { 1, 4 , 15, 1000, 1000000})]
        [TestCase(new int[] { int.MinValue, int.MaxValue, 0})]
        [TestCase(new int[0])]
        
        public void Test_Constructor_Input_leght(int [] parameters)
        {
            // Arrange
            Database database = new Database(parameters);
            // Assert
            Assert.AreEqual(
                parameters.Length,
                database.Count);
        }
        [TestCase(
            new int[] { 1, 4 },
            new int[] {11,12},
            4)]
        [TestCase(
            new int[0],
            new int[] { int.MinValue, int.MaxValue, 0 },
            3)]
        [TestCase(
            new int[0],
            new int[] { 1, 2, 3, 4, 5, 6, 7, 8, 9, 0, 1, 2, 3, 4, 5, 6 },
            16)]
        [Test]
        public void Test_Add_Valid_data_Method(
            int[] ctorParams,
            int[] paramsToAdd,
            int expected)
        {
            // Arrange
            Database database = new Database(ctorParams);
            // Act
            for (int i = 0; i < paramsToAdd.Length; i++)
            {
                database.Add(paramsToAdd[i]);
            }
            // Assert
            Assert.AreEqual(expected, database.Count);
        }
        [Test]
        [TestCase(
            new int[] { 1, 4 },
            new int[] { 1,2,3,4,5,6,7,8,9,0,1,2,3,4 })]
        public void Test_Add_INvalid_Data(
            int[] ctorParams,
            int[] paramsToAdd)
        {
            Database database = new Database(ctorParams);
            for (int i = 0; i < paramsToAdd.Length; i++)
            {
                database.Add(paramsToAdd[i]);
            }

            Assert.Throws<InvalidOperationException>(
                () => database.Add(1));
        
        }
        [Test]
        [TestCase(
            new int[0],
            new int[] { 1, 2, 3, 4, 5, 6, 7, 8, 9, 0, 1, 2, 3, 4, 5, 6 },
            11,
            5)]
        [TestCase(
            new int[] { 1},
            new int[] { 1},
            1,
            1)]

        public void Remove_Validdata_positive(int[] ctorParams,
            int[] paramsToAdd, int remove,
            int expected)
        {
            Database database = new Database(ctorParams);
            foreach (var item in paramsToAdd)
            {
                database.Add(item);
            }
            for (int i = 0; i < remove; i++)
            {
                database.Remove();
            }
            Assert.AreEqual(
                expected, database.Count);
        }

        [Test]
        [TestCase(
            new int[] { 1 },
            1)]
        [TestCase(
            new int[] { 1, 2, 3, 4, 5, 6, 7, 8, 9, 0, 1, 2, 3, 4, 5, 6 },
            16)]
        public void Remove_Exeption_Throw(int[] ctorParams,
            int toRemove)
        {
            Database database = new Database(ctorParams);
            for (int i = 0; i < toRemove; i++)
            {
                database.Remove();
            }
            Assert.Throws<InvalidOperationException>( ()
                    => database.Remove());

        }
        [Test]
        [TestCase(
            new int[] {}, 
            new int[] { 1, 2,3,4},
            2,
            new int[] {1,2})]
        public void Test_Fetch_ValidData(int[] ctorParams,
            int[] paramsToAdd, int remove,
            int[] expected)
        { 
            Database db = new Database();
            for (int i = 0; i < paramsToAdd.Length; i++)
            {
                db.Add(paramsToAdd[i]);
            }
            for (int i = 0; i < remove; i++)
            {
                db.Remove();
            }
            int[] actual = db.Fetch();

            Assert.AreEqual(expected, actual);

           


        }


    }
}

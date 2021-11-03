using Microsoft.VisualStudio.TestTools.UnitTesting;

namespace Projeto.Tests
{
    [TestClass]
    public class CalculadoraTests
    {
        [TestMethod]
        public void SomarTest()
        {
            //arrange
            var a = 1;
            var b = 1;

            //act
            var actual = Calculadora.Somar(a, b);

            //assert
            Assert.AreEqual(2, actual);
        }

        [DataTestMethod]
        [DataRow(1, 1, 2, DisplayName = "Primeiro Caso")]
        [DataRow(0, 1, 1, DisplayName = "Segundo Caso")]
        [DataRow(1, 2, 3, DisplayName = "Terceiro Caso")]
        public void SomarDataRowTest(int a, int b, int c)
        {
            //act
            var actual = Calculadora.Somar(a, b);

            //assert
            Assert.AreEqual(c, actual);
        }
    }
}
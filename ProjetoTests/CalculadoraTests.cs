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
    }
}
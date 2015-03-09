using System.Collections.Generic;
using CelticEgyptianRatscrewKata.SnapRules;
using Moq;
using NUnit.Framework;

namespace CelticEgyptianRatscrewKata.Tests
{
    public class SnapValidatorTests
    {
        [Test]
        public void ShouldNotBeSnappableIfAllRulesReturnFalse()
        {
            var ruleMock = new Mock<IRule>();
            ruleMock.Setup(x => x.CanSnap(It.IsAny<Cards>())).Returns(false);
            var rules = new List<IRule> { ruleMock.Object, ruleMock.Object };

            var stack = Cards.Empty();
            var snapValidator = new SnapValidator(rules);
            bool canSnap = snapValidator.CanSnap(stack);

            Assert.That(canSnap, Is.False);
        }

        [Test]
        public void ShouldBeSnappableIfARuleReturnsTrue()
        {
            var falseRuleMock = new Mock<IRule>();
            var trueRuleMock = new Mock<IRule>();
            falseRuleMock.Setup(x => x.CanSnap(It.IsAny<Cards>())).Returns(false);
            trueRuleMock.Setup(x => x.CanSnap(It.IsAny<Cards>())).Returns(true);
            var rules = new List<IRule> { falseRuleMock.Object, trueRuleMock.Object };

            var stack = Cards.Empty();
            var snapValidator = new SnapValidator(rules);
            bool canSnap = snapValidator.CanSnap(stack);

            Assert.That(canSnap, Is.True);
        }

        [Test]
        public void ShouldPassStackToRule()
        {
            var ruleMock = new Mock<IRule>();
            ruleMock.Setup(x => x.CanSnap(It.IsAny<Cards>())).Returns(false);
            var rules = new List<IRule> { ruleMock.Object };

            var stack = Cards.Empty();
            var snapValidator = new SnapValidator(rules);
            snapValidator.CanSnap(stack);

            ruleMock.Verify(r => r.CanSnap(stack), Times.Once());            
        }
    }
}
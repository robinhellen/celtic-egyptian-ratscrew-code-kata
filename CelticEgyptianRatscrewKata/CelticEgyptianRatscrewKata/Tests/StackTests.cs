using System.Collections.Generic;
using System.Linq;
using NUnit.Framework;

namespace CelticEgyptianRatscrewKata.Tests
{
    public class StackTests
    {
        [Test]
        public void ShouldReadTopCardOnStack()
        {
            var expectedCard = new Card(Suit.Clubs, Rank.Ace);
            var stack = new Stack(new List<Card> {expectedCard});

            CollectionAssert.AreEqual(stack, new List<Card> {expectedCard});
        }

        [Test]
        public void ShouldReadAllCards()
        {
            var expectedCardsInStack = new List<Card>
            {
                new Card(Suit.Clubs, Rank.Ace),
                new Card(Suit.Clubs, Rank.Two),
                new Card(Suit.Clubs, Rank.Three),
            };
            var stack = new Stack(expectedCardsInStack);

            CollectionAssert.AreEqual(stack, expectedCardsInStack);
            
        }
    }

    [TestFixture]
    public class SnapValidatorTests
    {
        [Test]
        public void NoSnapOnEmptyStack()
        {
            var stack = new Stack(Enumerable.Empty<Card>());
            var validator = new SnapValidator();

            Assert.False(validator.IsSnapValid(stack));
        }

        [Test]
        public void NotBlackQueenTest()
        {
            var expectedCardsInStack = new List<Card>
            {
                new Card(Suit.Clubs, Rank.Ace)
            };

            var stack = new Stack(expectedCardsInStack);
            var validator = new SnapValidator();

            Assert.False(validator.IsSnapValid(stack));

        }

        [Test]
        public void BlackQueenTest()
        {
            var expectedCardsInStack = new List<Card>
            {
                new Card(Suit.Spades, Rank.Queen)
            };

            var stack = new Stack(expectedCardsInStack);
            var validator = new SnapValidator();

            Assert.True(validator.IsSnapValid(stack));

        }

        [Test]
        public void CoveredBlackQueenTest()
        {
            var expectedCardsInStack = new List<Card>
            {
                new Card(Suit.Clubs, Rank.Queen),
                new Card(Suit.Spades, Rank.Queen),
            };

            var stack = new Stack(expectedCardsInStack);
            var validator = new SnapValidator();

            Assert.True(validator.IsSnapValid(stack));
        }

        [Test]
        public void CoveredBlackQueenTest2()
        {
            var expectedCardsInStack = new List<Card>
            {
                new Card(Suit.Spades, Rank.Queen),
                new Card(Suit.Clubs, Rank.Ten),
            };

            var stack = new Stack(expectedCardsInStack);
            var validator = new SnapValidator();

            Assert.False(validator.IsSnapValid(stack));
        }

        [Test]
        public void SandwichTest()
        {
            var expectedCardsInStack = new List<Card>
            {
                new Card(Suit.Hearts, Rank.Queen),
                new Card(Suit.Spades, Rank.Ten),
                new Card(Suit.Clubs, Rank.Queen),
            };

            var stack = new Stack(expectedCardsInStack);
            var validator = new SnapValidator();

            Assert.True(validator.IsSnapValid(stack));
        }

        [Test]
        public void BasicSnapTest()
        {
            var expectedCardsInStack = new List<Card>
            {
                new Card(Suit.Hearts, Rank.Queen),
                new Card(Suit.Clubs, Rank.Queen),
                new Card(Suit.Spades, Rank.Ten),
            };

            var stack = new Stack(expectedCardsInStack);
            var validator = new SnapValidator();

            Assert.True(validator.IsSnapValid(stack));
        }
    }
}
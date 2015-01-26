using System.Collections.Generic;
using System.Linq;
using System.Security.Cryptography.X509Certificates;
using NUnit.Framework;
using NUnit.Framework.Constraints;

namespace CelticEgyptianRatscrewKata
{
    public class SnapValidator
    {
        private List<IChecker> checkers;

        public SnapValidator()
        {
            checkers = new List<IChecker>
            {
                new BlackQueenChecker(),
                new SandwichChecker(2),
            };
        }

        public bool IsSnapValid(Stack stack)
        {
            foreach (var card in stack.Reverse())
            {
                if (checkers.Any(x => x.IsSnap(card)))
                    return true;
            }
            return false;
        }
    }

    public class SandwichChecker : IChecker
    {
        Queue<Card> lastTwo = new Queue<Card>();

        public SandwichChecker(int n)
        {
            for (int i = 0; i < n; i++)
            {
                lastTwo.Enqueue(null);
            }
        }

        public bool IsSnap(Card card)
        {
            var cardToMatch = lastTwo.Dequeue();
            lastTwo.Enqueue(card);

            return cardToMatch != null && cardToMatch.Rank == card.Rank;
        }
    }

    internal interface IChecker
    {
        bool IsSnap(Card card);
    }

    public class BlackQueenChecker : IChecker
    {
        private bool isTopmost = true;

        public bool IsSnap(Card card)
        {
            if (!isTopmost) return false;
            isTopmost = false;
            return card.Equals(new Card(Suit.Spades, Rank.Queen));
        }
    }
}
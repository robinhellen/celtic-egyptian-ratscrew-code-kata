

namespace CelticEgyptianRatscrewKata.SnapRules
{
    public class DarkQueenSnapRule : Object, IRule
    {
        private static Card s_QueenOfSpades = new Card(Suit.Spades, Rank.Queen);

        public bool CanSnap(Cards stack)
        {
            var topCard = stack.fold<Card?>((c, a) => a ?? c, null);
            return s_QueenOfSpades.Equals(topCard);
        }
    }
}

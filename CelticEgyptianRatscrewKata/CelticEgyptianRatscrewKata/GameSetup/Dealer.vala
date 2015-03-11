
using Gee;

namespace CelticEgyptianRatscrewKata.GameSetup
{
    public class Dealer : Object, IDealer
    {
        public Gee.List<Cards> Deal(int numberOfHands, Cards deck)
        {
            var hands = new ArrayList<Cards>();

            for (int i = 0; i < numberOfHands; i++)
            {
                hands.add(Cards.Empty());
            }

            while (deck.HasCards)
            {
                for (int i = 0; i < numberOfHands && deck.HasCards; i++)
                {
                    hands[i].AddToTop(deck.Pop());
                }
            }

            return hands;
        }
    }
}

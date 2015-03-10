using Gee;

namespace CelticEgyptianRatscrewKata.GameSetup
{
    public class Shuffler : IShuffler
    {
        private IRandomNumberGenerator m_RandomNumberGenerator;

        public Shuffler.Default()
        {
            m_RandomNumberGenerator = new RandomNumberGenerator.Default();
        }

        public Shuffler(IRandomNumberGenerator randomNumberGenerator)
        {
            m_RandomNumberGenerator = randomNumberGenerator;
        }

        public Cards Shuffle(Cards deck)
        {
            var shuffledDeck = new LinkedList<Card>();

            var unshuffledDeck = Cards.WithCards(deck);
            while (unshuffledDeck.HasCards)
            {
                var randomInt = m_RandomNumberGenerator.Get(0, unshuffledDeck.fold<int>((_, i) => i + 1, 0));
                var nextCard = unshuffledDeck.CardAt(randomInt);
                unshuffledDeck.RemoveCardAt(randomInt);
                shuffledDeck.add(nextCard);
            }

            return Cards.With(shuffledDeck.to_array());
        }
    }
}

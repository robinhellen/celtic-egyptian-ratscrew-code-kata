
namespace CelticEgyptianRatscrewKata.GameSetup
{
    public class Shuffler : IShuffler
    {
        private IRandomNumberGenerator m_RandomNumberGenerator;

        public Shuffler.Default()
        {
            m_RandomNumberGenerator = new RandomNumberGenerator();
        }

        public Shuffler(IRandomNumberGenerator randomNumberGenerator)
        {
            m_RandomNumberGenerator = randomNumberGenerator;
        }

        public Cards Shuffle(Cards deck)
        {
            var shuffledDeck = new List<Card>();

            var unshuffledDeck = Cards.With(deck.ToArray());
            while (unshuffledDeck.HasCards)
            {
                var randomInt = m_RandomNumberGenerator.Get(0, unshuffledDeck.Count());
                var nextCard = unshuffledDeck.CardAt(randomInt);
                unshuffledDeck.RemoveCardAt(randomInt);
                shuffledDeck.Add(nextCard);
            }

            return Cards.With(shuffledDeck.ToArray());
        }
    }
}

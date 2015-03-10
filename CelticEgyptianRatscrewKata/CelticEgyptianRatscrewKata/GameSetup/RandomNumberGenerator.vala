
namespace CelticEgyptianRatscrewKata.GameSetup
{
    class RandomNumberGenerator : IRandomNumberGenerator
    {
        private Random m_Random;

        public RandomNumberGenerator.Default()
        {
            m_Random = new Random();
        }

        public RandomNumberGenerator(int seed)
        {
            m_Random = new Random(seed);
        }

        public int Get(int minValue, int maxValue)
        {
            return m_Random.Next(minValue, maxValue);
        }
    }
}

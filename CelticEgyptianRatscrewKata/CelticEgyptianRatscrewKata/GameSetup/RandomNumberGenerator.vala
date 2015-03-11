
namespace CelticEgyptianRatscrewKata.GameSetup
{
    class RandomNumberGenerator : Object, IRandomNumberGenerator
    {
        public RandomNumberGenerator.Default()
        {
        }

        public RandomNumberGenerator(int seed)
        {
            Random.set_seed(seed);
        }

        public int Get(int minValue, int maxValue)
        {
            return Random.int_range(minValue, maxValue);
        }
    }
}

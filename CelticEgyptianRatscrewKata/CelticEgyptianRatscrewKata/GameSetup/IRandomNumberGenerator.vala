namespace CelticEgyptianRatscrewKata.GameSetup
{
    public interface IRandomNumberGenerator
    {
        public abstract int Get(int minValue, int maxValue);
    }
}

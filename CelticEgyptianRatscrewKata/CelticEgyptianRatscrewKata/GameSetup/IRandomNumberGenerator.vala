namespace CelticEgyptianRatscrewKata.GameSetup
{
    public interface IRandomNumberGenerator : Object
    {
        public abstract int Get(int minValue, int maxValue);
    }
}

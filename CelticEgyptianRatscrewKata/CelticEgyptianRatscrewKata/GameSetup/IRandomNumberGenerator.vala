namespace CelticEgyptianRatscrewKata.GameSetup
{
    public interface IRandomNumberGenerator
    {
        int Get(int minValue, int maxValue);
    }
}
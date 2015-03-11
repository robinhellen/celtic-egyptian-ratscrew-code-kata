
namespace CelticEgyptianRatscrewKata.GameSetup
{
    public interface IDealer : Object
    {
        public abstract Gee.List<Cards> Deal(int numberOfHands, Cards deck);
    }
}


namespace CelticEgyptianRatscrewKata.GameSetup
{
    public interface IDealer
    {
        public abstract Gee.List<Cards> Deal(int numberOfHands, Cards deck);
    }
}

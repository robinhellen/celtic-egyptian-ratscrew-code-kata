using Gee;

namespace CelticEgyptianRatscrewKata.Game
{
    public interface IGameState
    {
        /// <summary>
        /// Gets a copy of the current stack of cards.
        /// </summary>
        public abstract Cards Stack { get; }

        /// <summary>
        /// Add the given player to the game with the given deck.
        /// </summary>
        /// <exception cref="ArgumentException">If the given player already exists</exception>
        public abstract void AddPlayer(string playerId, Cards deck);

        /// <summary>
        /// Play the top card of the given player's deck.
        /// </summary>
        public abstract Card PlayCard(string playerId, bool addToTop = true);

        /// <summary>
        /// Wins the stack for the given player.
        /// </summary>
        public abstract void WinStack(string playerId);

        /// <summary>
        /// Returns true if the given player has any cards in their hand.
        /// </summary>
        public abstract bool HasCards(string playerId);

        /// <summary>
        /// Resets the game state back to its default values.
        /// </summary>
        public abstract void Clear();

        public abstract GameStateReport GetCurrentStateReport();
    }

    public class GameStateReport
    {
        public Card TopCard;
        public int StackSize;
        public Map<string, int> PlayerStacks;
    }
}

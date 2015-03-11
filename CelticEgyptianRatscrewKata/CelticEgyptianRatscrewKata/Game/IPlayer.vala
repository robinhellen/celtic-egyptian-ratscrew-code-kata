namespace CelticEgyptianRatscrewKata.Game
{
    /// <summary>
    /// Represents a player of the game.
    /// </summary>
    public interface IPlayer : Object
    {
        /// <summary>
        /// The name of the player, <em>must</em> be unique.
        /// </summary>
        public abstract string Name { get; }
    }
}

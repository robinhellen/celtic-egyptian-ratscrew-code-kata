
namespace CelticEgyptianRatscrewKata.SnapRules
{
    public class SnapValidator : ISnapValidator
    {
        private IEnumerable<IRule> m_Rules;

        public SnapValidator(IEnumerable<IRule> rules)
        {
            m_Rules = rules;
        }

        public bool CanSnap(Cards stack)
        {
            return m_Rules.Any(rule => rule.CanSnap(stack));
        }
    }
}

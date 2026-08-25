using Cake.Core;
using Cake.Frosting;

public class BuildContext : FrostingContext
{
    public string Path { get; set; }

    public BuildContext(ICakeContext context)
        : base(context)
    {
        Path = context.Arguments.GetArgument("Path");
    }
}
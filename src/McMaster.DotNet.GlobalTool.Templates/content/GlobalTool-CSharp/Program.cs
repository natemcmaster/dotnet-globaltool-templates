using System;
using McMaster.Extensions.CommandLineUtils;

namespace My.Tool
{
    [Command(Description = "My global command line tool.")]
    [HelpOption("--help")]
    class Program
    {
        public static int Main(string[] args) => CommandLineApplication.Execute<Program>(args);

        [Option(Description = "The name of the person to greet.")]
        public string Name { get; } = "world";

        private int OnExecute()
        {
            Console.WriteLine($"Hello {Name}");
            return 0;
        }
    }
}

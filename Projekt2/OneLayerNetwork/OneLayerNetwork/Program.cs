using System;
using System.Collections.Generic;


namespace OneLayerNetwork
{
    class Program
    {
        static void Main(string[] args)
        {
            var learningRate = 0.1;
            Console.WriteLine("Learning rate: " + learningRate);

            Console.WriteLine("Adaline");

            var adaline = new Adaline(learningRate);
            adaline.Learn();
            adaline.Test();

            Console.WriteLine("Delta rule");

            var deltaRule = new DeltaRule(learningRate);
            deltaRule.Learn();
            deltaRule.Test();

        }
    }
}

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
            var adaline = new Adaline(learningRate);
            adaline.Learn();
            adaline.Test();

        }
    }
}

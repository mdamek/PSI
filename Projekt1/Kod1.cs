using System;

namespace Perceptron
{
    class Perceptron
    {
        static void Main(string[] args)
        {
            Console.WriteLine("Perceptor for AND function");
            var input = new[,] {{1, 0}, {1, 1}, {0, 1}, {0, 0}, { 1, 0 }, { 1, 1 }, { 0, 1 }, { 0, 0 } };
            int[] outputs = {0, 1, 0, 0, 0, 1, 0, 0 };
            var random = new Random();

            double[] weights = {random.NextDouble() - 0.5, random.NextDouble() - 0.5, random.NextDouble() - 0.5 };

            const double learningRate = 1;
            double totalError = 1;
            var licznik = 0;
            while (totalError > 0)
            {
                totalError = 0;
                Console.WriteLine(++licznik);
                for (var i = 0; i < 8; i++)
                {
                    
                    var output = CalculateOutput(input[i, 0], input[i, 1], weights);

                    var error = outputs[i] - output;

                    weights[0] += learningRate * error * input[i, 0];
                    weights[1] += learningRate * error * input[i, 1];
                    weights[2] += learningRate * error * 1;
                    totalError += error * error;
                }
            }


            var dataToTest = new[,]
            {
                {1, 0}, {0, 1}, {1, 1}, {0, 0}
            };
            var dataToCompare = new[] {0, 0, 1, 0};

            Console.WriteLine("Model test");
            for (var i = 0; i < 4; i++)
            {
                var answer = CalculateOutput(dataToTest[i, 0], dataToTest[i, 1], weights);
                if (dataToCompare[i] != answer)
                {
                    Console.WriteLine("Error on pair {0}, expected {1} from {2}:{3} but was {4}", i, dataToCompare[i],
                        dataToTest[i, 0], dataToTest[i, 1], answer);
                }
            }

            Console.ReadLine();
        }

        private static int CalculateOutput(double input1, double input2, double[] weights)
        {
            var sum = input1 * weights[0] + input2 * weights[1] + 1 * weights[2];
            return (sum >= 0) ? 1 : 0;
        }
    }
}

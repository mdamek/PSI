using System;
using System.Collections.Generic;
using System.IO;

namespace OneLayerNetwork
{
    public class DeltaRule
    {
        private readonly List<double> _weightsContainer;
        private readonly double _learningRate;
        private readonly int[,] _inputData;
        private readonly int[,] _testData;
        private readonly int[] _expectedResults;
        private readonly int _numberOfLetters;
        private readonly int _numberOfFields;
        private readonly char[] _setTestLetters;
        private double _error;
        private double _delta;
        private double _output;

        public DeltaRule(double learningRate)
        {
            _setTestLetters = new[]
                {'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j'};
            _learningRate = learningRate;
            _delta = 0;
            _numberOfFields = 35;
            _numberOfLetters = 20;
            _expectedResults = new int[20];
            _error = 0.0;
            _weightsContainer = new List<double>();
            var random = new Random();
            for (var i = 0; i < _numberOfFields; i++)
            {
                _weightsContainer.Add(random.NextDouble());
            }

            _inputData = ReadDataFromFile("C:\\repositories\\PSI\\Projekt2\\OneLayerNetwork\\data_for_learning.txt");
            _testData = ReadDataFromFile("C:\\repositories\\PSI\\Projekt2\\OneLayerNetwork\\data_for_test.txt");
            for (var i = 0; i < 20; i++)
            {
                if (i < 10)
                    _expectedResults[i] = 1;
                else
                {
                    _expectedResults[i] = 0;
                }
            }
        }

        private int[,] ReadDataFromFile(string url)
        {
            var input = File.ReadAllText(url);

            var i = 0;
            var result = new int[_numberOfLetters, _numberOfFields];
            foreach (var row in input.Split('\n'))
            {
                var j = 0;
                foreach (var col in row.Trim().Split(' '))
                {
                    result[i, j] = int.Parse(col.Trim());
                    j++;
                }

                i++;
            }

            return result;
        }

        private int[] getOneRow(int[,] inputData, int whichRow)
        {
            var tablica = new int[35];
            for (var i = 0; i < tablica.Length; i++)
            {
                tablica[i] = inputData[whichRow, i];
            }

            return tablica;
        }

        private double Sum(IReadOnlyList<int> letter, IReadOnlyList<double> weightsContainer)
        {
            var sum = 0.0;
            for (var i = 0; i < _numberOfFields; i++)
                sum += letter[i] * weightsContainer[i];
            return sum;
        }

        public void Test()
        {
            Console.WriteLine("Test letters: ");
            for (var i = 0; i < _numberOfLetters; i++)
            {
                Console.WriteLine("Letter " + _setTestLetters[i] + " is: ");
                Console.WriteLine(ActivationFunction(Sum(getOneRow(_testData, i), _weightsContainer)) > 0.5
                    ? "Big"
                    : "Small");
            }

            Console.ReadLine();
        }

        public void Learn()
        {
            bool acceptableError;

            var epoch = 0;

            do
            {
                epoch++;
                _error = 0.0;
                for (var i = 0; i < _numberOfLetters; i++)
                {
                    _output = ActivationFunction(Sum(getOneRow(_inputData, i), _weightsContainer));

                    _delta = _expectedResults[i] - _output;

                    for (var j = 0; j < _numberOfFields; j++)
                        _weightsContainer[j] += _learningRate * _delta * _inputData[i, j] *
                                                DerivativeActivationFunction(Sum(getOneRow(_inputData, i),
                                                    _weightsContainer));

                    _error += _delta * _delta;
                }

                _error /= 2;

                acceptableError = !(_error > 0.1);
            } while (!acceptableError);

            Console.WriteLine("Epoch: " + epoch);
            Console.WriteLine("MSE error: " + _error);
        }

        private static double DerivativeActivationFunction(double sum)
        {
            return (1.0 * Math.Exp(-1.0 * sum)) / (Math.Pow(Math.Exp(-1.0 * sum) + 1, 2));
        }

        private double ActivationFunction(double sum)
        {
            return (1 / (1 + Math.Exp(-1.0 * sum)));
        }
    }
}
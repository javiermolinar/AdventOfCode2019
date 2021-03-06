<<<<<<< HEAD
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;

namespace ConsoleApp5
{
    class Program
    {
        static void Main(string[] args)
        {
            var path = Directory.GetCurrentDirectory() + "\\input.txt";
            var input = File.ReadAllText(path);
          
            int [] myArray = { 1, 2, 3, 4, 5, 6, 7, 8, 9, 0, 1, 2 };
            int sizeOfLayer = 6;            
            List<List<int>> myImage = new List<List<int>>();
            List<int> myLayer = new List<int>();

            for (int i = 0; i < myArray.Length; i++)
            {
                int pos = i % sizeOfLayer;
                myLayer.Add(myArray[i]);

                if(pos == sizeOfLayer - 1)
                {
                    myImage.Add(myLayer);
                    myLayer = new List<int>();
                }
            }

            int minNumberOfZeroes = 0;
            int calculatedNumber = 0;

            foreach (var layer in myImage)
            {
                int numberOf0 = 0;
                int numberOf1 = 0;
                int numberOf2 = 0;

                foreach(var number in layer)
                {
                    switch (number)
                    {
                        case 0: numberOf0++;
                            break;
                        case 1:
                            numberOf1++;
                            break;
                        case 2:
                            numberOf2++;
                            break;
                    }

                }
                if(numberOf0 > minNumberOfZeroes)
                {
                    minNumberOfZeroes = numberOf0;
                    calculatedNumber = numberOf1 * numberOf2;
                }

            }

            Console.WriteLine(calculatedNumber);


        }
    }      

       
}
=======
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;

namespace ConsoleApp5
{
   
    class Program
    {
        static void Main(string[] args)
        {                    
            var myArray = File.ReadAllText(Directory.GetCurrentDirectory() + "\\input.txt").ToCharArray().Select(x=>x-'0').ToArray();   
            
            int sizeOfLayer = 150;                  
            List<List<int>> myImage = new List<List<int>>();
            List<int> myLayer = new List<int>();

            for (int i = 0; i < myArray.Length; i++)
            {
                int pos = i % sizeOfLayer;
                myLayer.Add(myArray[i]);

                if(pos == sizeOfLayer - 1)
                {
                    myImage.Add(myLayer);
                    myLayer = new List<int>();
                }
            }         
          
            int calculatedNumber = GetCalculatedValue(myImage.OrderBy(x=>x.Count(y=>y == 0)).FirstOrDefault());             

            Console.WriteLine(calculatedNumber);    
        }

        static int GetCalculatedValue(List<int> layer) => layer.Count(x=>x==1) * layer.Count(x=>x==2);        

    }
}
>>>>>>> 45df7474e36414b5cd489452c82f16885a5fc557

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

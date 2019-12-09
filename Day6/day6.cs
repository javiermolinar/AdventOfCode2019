using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;

namespace ConsoleApp5
{
    struct Node
    {
        public string name;   
        public List<Node> nodes;        
    }
    class Program
    {
        static void Main(string[] args)
        {
            var path = Directory.GetCurrentDirectory() + "\\input.txt";
            List<string> input = new List<string> (File.ReadLines(path));
            List<Node> planets = new List<Node>();            
 
            foreach( var orbit in input)
            {
                Node parentPlanet = new Node();
                Node orbitPlanet = planets.FirstOrDefault(x => x.name == orbit.Split(")")[1]);

                foreach(var planet in planets)
                {
                   var found = Find(orbit.Split(")")[0], planet);
                   if(found.name == orbit.Split(")")[0])
                    {
                        parentPlanet = found;
                        break;
                    }
                }

                if (string.IsNullOrEmpty(parentPlanet.name))
                {
                    parentPlanet = new Node() { name = orbit.Split(")")[0], nodes = new List<Node>() };
                    planets.Add(parentPlanet);
                }

                if (string.IsNullOrEmpty(orbitPlanet.name))
                {
                    orbitPlanet = new Node() { name = orbit.Split(")")[1], nodes = new List<Node>() };
                }
                else
                {
                    planets.Remove(orbitPlanet);
                }


                parentPlanet.nodes.Add(orbitPlanet);

            }

            int orbits = 0;
            foreach (var planet in planets)
            {
                orbits += GetOrbits(planet,0);
            }
            Console.WriteLine($"Orbits{orbits}");
        }

        public static Node Find(string nodeName, Node currentNode)
        {
            if(currentNode.name == nodeName)
            {
                return currentNode;
            }
            if(currentNode.nodes.Count == 0)
            {
                return new Node();
            }          

            foreach(var node in currentNode.nodes)
            {
                var nodefound = Find(nodeName, node);
                if(nodefound.name == nodeName)
                {
                    return nodefound;
                }
            }
            return new Node();
        }

        public static int GetOrbits(Node currentNode, int depth)
        {
            if (currentNode.nodes.Count == 0)
            {
                return depth;
            }

            int orbits = 0;
            foreach(var node in currentNode.nodes)
            {
                orbits += GetOrbits(node,depth+1);
            }
            return depth + orbits;
        }
    }
}

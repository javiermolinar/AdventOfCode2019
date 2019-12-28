class Node {
    has Str $.name;
    has int $.depth;
    has Node @.nodes;
}

sub FindNode($nodeName,$currentNode){  
    if $currentNode.name eq $nodeName {         
        return $currentNode;
    }
    if $currentNode.nodes.elems == 0 {         
        return Node.new(name =>"" , depth =>-1 , nodes => {} );
    }
    for $currentNode.nodes -> $node {      
        my $foundName = FindNode($nodeName,$node);
        if $foundName.name eq $nodeName { 
            return $foundName;
        }
    }  
    return Node.new(name =>"" , depth =>-1 , nodes => {} );  
}

sub AddNewNode($parentNodeName, $nodeName, $rootNode ) {
    my $parentNode = FindNode($parentNodeName,$rootNode);      
    if $parentNode.name ne "" {
         $parentNode.nodes.push(Node.new(name => $nodeName , depth =>$parentNode.depth + 1 , nodes => {} ));  
    }   
}

sub GetOrbits($currentNode) {    
    if $currentNode.nodes.elems == 0 {     
        return $currentNode.depth;
    }
    my $totalDepth = 0;
    for $currentNode.nodes -> $node {
        $totalDepth += GetOrbits($node);      
    }
     return $currentNode.depth + $totalDepth;
}

#Creating root node
# my $node = Node.new(name => "COM",depth => 0, nodes => {} );

#Iterating list

my @map = 'input.txt'.IO.lines;
my $node = Node.new(name => @map[0].split(")")[0],depth => 0, nodes => {} );

for @map -> $value {
    say "Adding input: ", $value;
    AddNewNode($value.split(")")[0],$value.split(")")[1],$node)
}


say $node;
# say GetOrbits($node);

#say GetOrbits($node);



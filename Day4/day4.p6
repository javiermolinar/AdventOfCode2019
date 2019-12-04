#Could this be a regular expression?
sub IsPasswordValid($password) {
    if $password.chars != 6 {
         return 0;
    }
    my $containsAdjacents = 0;
    my $lastNumber = $password.substr(0,1); 

    loop (my $i=1;$i < 6;$i++){
        my $number =  $password.substr($i,1);
        if $number < $lastNumber {
            return 0;
        }
        if $number == $lastNumber {
            $containsAdjacents = 1;
        }
        $lastNumber = $number;
    }
    return $containsAdjacents;
}

sub IsPasswordValid2($password) {
    if $password.chars != 6 {
         return 0;
    }
    #It has to be a better way to do this
    my @adjacents[10] = [0,0,0,0,0,0,0,0,0,0];
    my $lastNumber = $password.substr(0,1); 

    loop (my $i=1;$i < 6;$i++){
        my $number =  $password.substr($i,1);
        if $number < $lastNumber {
            return 0;
        }
        if $number == $lastNumber {
           @adjacents[$number]++;
        }
        $lastNumber = $number;
    }   
    return @adjacents.grep({$_== 1}).elems >= 1;
}


say (125730 ... 579381).grep({IsPasswordValid2($_)}).elems;


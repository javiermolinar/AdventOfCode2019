sub Add(@program,$value1,$value2,$destination){   
    @program[$destination] = $value1 + $value2;   

    say "Position $destination is @program[$destination] after adding $value1 and $value2 "; 
}

sub Multiply(@program,$value1,$value2,$destination){    
    @program[$destination] = $value1 * $value2; 
    say "Position $destination is @program[$destination] after multiply $value1 and $value2 "; 
}

sub GetValueForMode(@program,$mode,$value) {        
    return $mode == 0 ?? @program[$value] !! $value;
}


sub Snapshot(@program){
    say "taking a snapshot: ";
    my $fh = open "testfile", :w;

    for  @program -> $array-item {
        $fh.say($array-item);
    }

    $fh.close;
}

sub Snapshot1(@program){
    say "taking a snapshot: ";
    my $fh = open "testfile2", :w;

    
    $fh.print(@program);
    

    $fh.close;
}

sub IntCode(@program,$position){
    say 'operations:', @program[$position];
    say 'position:', $position;
    # if @program[$position] == "1002" && $position == 160 {
    #     Snapshot(@program);
    #      Snapshot1(@program);
    #     die("Algo ha pasado");
    # }
    given @program[$position] {
        when '99' { return  @program;}
        when '1' {  
           Add(@program, @program[@program[$position+1]],@program[@program[$position+2]], @program[$position+3]);            
           return IntCode(@program.clone(),$position+4);
        }
        when '2' {  
            Multiply(@program, @program[@program[$position+1]],@program[@program[$position+2]],@program[$position+3]);     
            return IntCode(@program.clone(),$position+4);
        }
        when '3' {
           @program[@program[$position+1]] = prompt 'Enter input: ';         
           return IntCode(@program,$position+2);
        }
        when '4' { 
           say "Output1 = ",@program[@program[$position+1]];                
           return IntCode(@program.clone(),$position+2);
        }
        when @program[$position].chars >=3 {

            my $instruction = @program[$position];          
            my $optCode = $instruction.substr($instruction.chars-2,2);           
            my $firstParameterMode = $instruction.substr($instruction.chars-3,1);           
            my $secondParameterMode = $instruction.chars > 3 ?? $instruction.substr($instruction.chars-4,1) !! 0;        
            my $thirdParameterMode = $instruction.chars > 4 ?? $instruction.substr($instruction.chars-5,1) !! 0;
          
            
            given $optCode {
                when '99' { return  @program;}
                when '01' {
                    Add(
                        @program,
                        GetValueForMode(@program,$firstParameterMode,@program[$position+1]),
                        GetValueForMode(@program,$secondParameterMode,@program[$position+2]),
                        GetValueForMode(@program,0,@program[$position+3])
                    );
                }
                when '02' {
                     Multiply(
                        @program,
                        GetValueForMode(@program,$firstParameterMode,@program[$position+1]),
                        GetValueForMode(@program,$secondParameterMode,@program[$position+2]),
                        GetValueForMode(@program,0,@program[$position+3])
                    );
                }  
                when '04' {                                                    
                    say "Output2 = ",GetValueForMode(@program,$firstParameterMode,@program[$position+1]);                     
                    return IntCode(@program.clone(),$position+2);       
                }  
                default { die("Wrong value in optcode: @program[$position]");}              
            }     
            return IntCode(@program.clone(),$position+4);
        }
        default { die("Wrong value: @program[$position]");}
    }
};


my @program = (slurp "program.txt").split(",");

#my @program = (slurp "testfile2").split(" ");

IntCode(@program.clone(),0);



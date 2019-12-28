sub IntCode(@program,$position){
    given @program[$position] {

        when 99 { return  @program;}
        when 1 { 
            my @newProgramVersion = @program.clone();
            @newProgramVersion[@newProgramVersion[$position+3]] = 
             @newProgramVersion[@newProgramVersion[$position+1]] +  @newProgramVersion[@newProgramVersion[$position+2]];
            return IntCode(@newProgramVersion,$position+4);
        }
        when 2 { 
            my @newProgramVersion = @program.clone();
            @newProgramVersion[@newProgramVersion[$position+3]] = 
             @newProgramVersion[@newProgramVersion[$position+1]] *  @newProgramVersion[@newProgramVersion[$position+2]];
            return IntCode(@newProgramVersion,$position+4);
        }
        default { return  @program;}
    }
};

sub GetNounAndVerb(@program){

    loop (my $i = 0; $i < 90; $i++) {
        loop (my $j = 0; $j < 90; $j++) {            
            my @alteredProgram = @program.clone();
            #Replacement instructions
            @alteredProgram[1] = $i;
            @alteredProgram[2] = $j;   
            my @programSet = IntCode(@alteredProgram,0);
            if @programSet[0] == 19690720 {
                return %( 'noun' => $i, 'verb' => $j );
            } 
        }
    }      
    return %( 'noun' => 0, 'verb' => 0 );
}

my @program = (slurp "program.txt").split(",").map({ .Numeric });

#Replacement instructions
#@program[1] = 12;
#@program[2] = 2;
#IntCode(@program,0).say;

my %nounAndVerb = GetNounAndVerb(@program);
my $total = %nounAndVerb<noun>*100 + %nounAndVerb<verb>;

say "Noun and verb needed: %nounAndVerb<noun>, %nounAndVerb<verb>, total: $total";
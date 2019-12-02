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

my @program = (slurp "program.txt").split(",").map({ .Numeric });

#Replacement instructions
@program[1] = 12;
@program[2] = 2;

IntCode(@program,0).say;
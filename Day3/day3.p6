sub GetInitializedSquareGrid ($size){
    my @grid[$size;$size];
    #I guess there is a faster and fancy way to do this
    loop (my $i = 0; $i < $size; $i++) {
        loop (my $j = 0; $j < $size; $j++) {
            @grid[$i;$j] = 0;
        }
    }
    return @grid;
}

sub SetCenterOfTheGrid($grid){   
   
    my $centerI= $grid.shape[0] div 2;
    my $centerJ = $grid.shape[1] div 2;
    $grid[$centerI;$centerJ]= -1;

    return %( 'posI' => $centerI, 'posJ' => $centerJ  );
}


sub WritePath(@path,@grid,$posI,$posJ){
    if @path.elems == 0 {
        return @grid;
    }    
    my $nextMove = @path.shift;        
    my %currentPosition = FillValues(@grid,$posI,$posJ,$nextMove.substr(1,$nextMove.chars-1), substr($nextMove,0,1));
    
    WritePath(@path,@grid,%currentPosition<posI>,%currentPosition<posJ>)
}

sub FillValues($grid,$initialPosI,$initialPosJ,$movements,$direction){    
    my $posI = $initialPosI;
    my $posJ = $initialPosJ;   

    given $direction {
            when "U" {
               loop (my $i = 1; $i <= $movements; $i++) {
                    $grid[$initialPosI-$i;$initialPosJ]++;
               }
               $posI -= $movements;
            }
            when "R" {
               loop (my $i = 1; $i <= $movements; $i++) {
                    $grid[$initialPosI;$initialPosJ + $i]++;
               }
               $posJ += $movements;
            }
            when "D" {
               loop (my $i = 1; $i <= $movements; $i++) {
                    $grid[$initialPosI+$i;$initialPosJ]++;
               }
               $posI += $movements;
            }
            when "L" {
               loop (my $i = 1; $i <= $movements; $i++) {
                    $grid[$initialPosI;$initialPosJ-$i]++;
               }
                $posJ -= $movements;
            }
    }
    return %( 'posI' => $posI, 'posJ' => $posJ  );
}

sub CalculateMinDistance ($centerI,$centerJ, @grid){
    #quick and dirty
    my $lowerDistance = 1000000000;
    loop (my $i = 0; $i < @grid.shape[0]; $i++) {
          loop (my $j = 0; $j < @grid.shape[1]; $j++) {
             if @grid[$i;$j] == 2 {
                 my $distance = abs($i - $centerI) + abs($j-$centerJ);  
                 if  $distance < $lowerDistance {
                    $lowerDistance =  $distance;                     
                 }
             }
        }
    }
    return $lowerDistance;
}

my @input = 'input.txt'.IO.lines;
my @path = @input[0].split(",");
my @path2 =  @input[1].split(",");

my $grid = GetInitializedSquareGrid(6000);
my %center = SetCenterOfTheGrid($grid);

WritePath @path, $grid, %center<posI>,%center<posJ>;
WritePath @path2, $grid,  %center<posI>,%center<posJ>;

say "Minimun distance = ",CalculateMinDistance %center<posI>,%center<posJ>, $grid;

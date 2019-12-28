#my @picture = (slurp "inpuit.txt");
my @picture = 1,2,3,4,5,6,7,8,9,0,1,2;
my $sizeOfLayer = 6;
my $numberOfLayers = @picture.elems / $sizeOfLayer;
my @image = [[0 xx $sizeOfLayer] xx $numberOfLayers];
my $layer = 0;

loop (my $i = 0; $i < @picture.elems; $i++) {
  my $pos = $i % $sizeOfLayer; 
  @image[$layer;$pos] = @picture[$i];
  if $pos == $sizeOfLayer-1 {
      $layer++; 
  }
}

my $fewerZeroesLayer = 0;
my $numberOfCalculatedZeroes = 0;
my $calculatedNumber = 0;


loop ($i = 0; $i <6 ; $i++) {
  my $numberOfZeroes = 0;
  my $numberOfOnes = 0;
  my $numberOfTwo = 0;

  loop (my $j = 0; $j < 2; $j++) {
    say @image[$i;$j];
    given  @image[$i;$j] {
      when 0 { $numberOfZeroes++; }
      when 1 { $numberOfOnes++; }
      when 2 { $numberOfTwo++; }
    }
  }
  if $numberOfZeroes > $numberOfCalculatedZeroes {
    $fewerZeroesLayer = $j;
    $numberOfCalculatedZeroes = $numberOfZeroes;
    $calculatedNumber = $numberOfOnes * $numberOfTwo;
  }
}


say @image;
say $fewerZeroesLayer;
say $calculatedNumber;
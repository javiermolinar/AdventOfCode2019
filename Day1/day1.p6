sub  getFuelForMass($mass){
    return ($mass div 3) - 2;
}

sub getTotalFuelForMass($mass){    
    my $fuel = getFuelForMass($mass);   
    if $fuel <= 0 {
        return 0;
    }
    return $fuel  + getTotalFuelForMass($fuel );
}

say 'Fuel needed: ', [+] 'modules.txt'.IO.lines.map({ getFuelForMass($_.Numeric) });
say 'Total Fuel needed: ', [+] 'modules.txt'.IO.lines.map({ getTotalFuelForMass($_.Numeric) });
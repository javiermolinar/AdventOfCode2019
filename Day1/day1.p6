sub  getFuelForMass($mass){
    return ($mass div 3) - 2;
}

say 'Fuel needed: ', [+] 'modules.txt'.IO.lines.map({ getFuelForMass($_.Numeric) });
#!/bin/bash

module load matlab
for i  in {0..20}
do
bsub -q new-long -R "rusage[mem=6000]" "matlab -batch "n20m6uniform0p2paiJdisorderSeed$i""   
 
done

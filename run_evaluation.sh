#!/bin/bash
scenarios="lookup_anonymous"
numUsers="2"
numServers="7"

cd "$(dirname "$0")";

set -e;
cd pudding;
cargo build --release;
cd ..;
set +e;

mkdir -p output

# prefix that is the datetime when the evaluation started
prefix=$(date +%Y%m%d-%H%M)
hostname=$(hostname)

for numUser in $numUsers; do
  for numServer in $numServers; do
    for scenario in $scenarios; do
      outputFilename="output/$prefix-$hostname-$scenario-u$numUser-s$numServer.log";
      set -o pipefail; # Makes the first failed command fail the pipe
      ./pudding/target/release/pudding -u $numUser -s $numServer --runtime-seconds 600 --scenario $scenario --no-color | tee $outputFilename;
    done
  done
done

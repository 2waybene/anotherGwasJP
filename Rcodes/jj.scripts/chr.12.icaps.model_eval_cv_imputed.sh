#!/bin/bash
TIMEFORMAT='    %lR';
date

p=$1
chr=$2

if [ $chr -ge 100 ]; then
	chr=$((chr-100))
  for f in $(ls ../imputation/outputs/chr${chr}.*gz | sort -nt. -k5);do
    chunk=${f%.gz}
    chunk=${chunk##*.}
    if [[ ( "$chr" -eq 1 && "$chunk" -ge 25 ) || \
          ( "$chr" -eq 2 && "$chunk" -ge 26 ) || \
          ( "$chr" -eq 3 && "$chunk" -ge 20 ) || \
          ( "$chr" -eq 4 && "$chunk" -ge 20 ) || \
          ( "$chr" -eq 5 && "$chunk" -ge 20 ) || \
          ( "$chr" -eq 6 && "$chunk" -ge 16 ) || \
          ( "$chr" -eq 7 && "$chunk" -ge 16 ) || \
          ( "$chr" -eq 8 && "$chunk" -ge 15 ) || \
          ( "$chr" -eq 9 && "$chunk" -ge 15 ) || \
          ( "$chr" -eq 10 && "$chunk" -ge 14 ) || \
          ( "$chr" -eq 11 && "$chunk" -ge 14 ) || \
          ( "$chr" -eq 12 && "$chunk" -ge 14 ) \
        ]]; then
      echo $f
      time R --slave --vanilla --file=bin/compute_cv.r --args $p $chr $chunk
      #time R --slave --vanilla --file=bin/compute_cv_imputeForMetaAnalysis.r --args $p $chr $chunk
    fi
  done
else
  for f in $(ls ../imputation/outputs/chr${chr}.*gz | sort -nt. -k5);do
    chunk=${f%.gz}
    chunk=${chunk##*.}
    if [[ ( "$chr" -eq 1 && "$chunk" -lt 25 ) || \
          ( "$chr" -eq 2 && "$chunk" -lt 26 ) || \
          ( "$chr" -eq 3 && "$chunk" -lt 20 ) || \
          ( "$chr" -eq 4 && "$chunk" -lt 20 ) || \
          ( "$chr" -eq 5 && "$chunk" -lt 20 ) || \
          ( "$chr" -eq 6 && "$chunk" -lt 16 ) || \
          ( "$chr" -eq 7 && "$chunk" -lt 16 ) || \
          ( "$chr" -eq 8 && "$chunk" -lt 15 ) || \
          ( "$chr" -eq 9 && "$chunk" -lt 15 ) || \
          ( "$chr" -eq 10 && "$chunk" -lt 14 ) || \
          ( "$chr" -eq 11 && "$chunk" -lt 14 ) || \
          ( "$chr" -eq 12 && "$chunk" -lt 14 ) || \
          ( "$chr" -ge 13 ) \
        ]]; then
      echo $f
      time R --slave --vanilla --file=bin/compute_cv.r --args $p $chr $chunk
      #time R --slave --vanilla --file=bin/compute_cv_imputeForMetaAnalysis.r --args $p $chr $chunk
    fi
  done
fi
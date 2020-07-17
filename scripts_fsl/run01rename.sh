#!/bin/bash

# Change to directory of SS_task's designs

cd /home/people/dxh814/replication/assessment_data/feat/1/designs/SS_task



# Create model files for SS_task run02: sub-02, sub-03, sub-04, sub-06 sub-07,sub-12, sub-13, sub-14,sub-17, sub-18, sub-20, sub-21, sub-23 sub-24, sub-25, sub-26, sub-29

for sub in sub-01 sub-02 sub-03 sub-04 sub-05 sub-06 sub-07 sub-09 sub-10 sub-11 sub-12 sub-13 sub-14 sub-16 sub-17 sub-18 sub-20 sub-21 sub-23 sub-24 sub-25 sub-26 sub-28 sub-29
do
cp ${sub}_SS_run01.fsf ${sub}_SS_run02.fsf
perl -i -p -e s/run01*/run02*/ ${sub}_SS_run02.fsf
done

# Create model files for SS_task run02: sub-6, sub-07, sub-09, sub-10, sub-11, sub-16, sub-28

# Create model files for SS_task run01: sub-02, sub-03, sub-04, sub-06 sub-07,sub-12, sub-13, sub-14,sub-17, sub-18, sub-20, sub-21, sub-23 sub-24, sub-25, sub-26, sub-28, sub-29




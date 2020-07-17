#!/bin/bash

# Change to directory of SS_task's designs

cd /home/people/dxh814/replication/assessment_data/feat/1/designs/SS_task

# Copy over the saved model file (design.fsf) of sub-01_SS_run02

cp /home/people/dxh814/replication/assessment_data/feat/1/sub-01_SS_run02.feat/design.fsf sub-01_SS_run02.fsf

# Copy over the saved model file of sub-05_SS_run02, as different design matrix is needed due to the missing sub-xx_task-stopsignal_run-xx_label-goincorrect.txt for sub-05,09,10,11,16 and sub-06_run02,07_run02,28_run02

cp /home/people/dxh814/replication/assessment_data/feat/1/sub-05_SS_run02.feat/design.fsf sub-05_SS_run02.fsf

# Create model files for SS_task run02: sub-02, sub-03, sub-04, sub-06 sub-07,sub-12, sub-13, sub-14,sub-17, sub-18, sub-20, sub-21, sub-23 sub-24, sub-25, sub-26, sub-29

for sub in sub-02 sub-03 sub-04 sub-12 sub-13 sub-14 sub-17 sub-18 sub-20 sub-21 sub-23 sub-24 sub-25 sub-26 sub-29
do
cp sub-01_SS_run02.fsf ${sub}_SS_run02.fsf
perl -i -p -e s/sub-01/${sub}/ ${sub}_SS_run02.fsf
done

# Create model files for SS_task run02: sub-6, sub-07, sub-09, sub-10, sub-11, sub-16, sub-28

for sub in sub-06 sub-07 sub-09 sub-10 sub-11 sub-16 sub-28 
do
cp sub-05_SS_run02.fsf ${sub}_SS_run02.fsf
perl -i -p -e s/sub-05/${sub}/ ${sub}_SS_run02.fsf
done


# Fix the correct subject numbers in non-elegant way

perl -i -p -e s/sub-01/sub-02/  sub-02_SS_run02.fsf
perl -i -p -e s/sub-01/sub-03/  sub-03_SS_run02.fsf
perl -i -p -e s/sub-01/sub-04/  sub-04_SS_run02.fsf
perl -i -p -e s/sub-01/sub-12/  sub-12_SS_run02.fsf
perl -i -p -e s/sub-01/sub-13/  sub-13_SS_run02.fsf
perl -i -p -e s/sub-01/sub-14/  sub-14_SS_run02.fsf
perl -i -p -e s/sub-01/sub-17/  sub-17_SS_run02.fsf
perl -i -p -e s/sub-01/sub-18/  sub-18_SS_run02.fsf
perl -i -p -e s/sub-01/sub-20/  sub-20_SS_run02.fsf
perl -i -p -e s/sub-01/sub-21/  sub-21_SS_run02.fsf
perl -i -p -e s/sub-01/sub-23/  sub-23_SS_run02.fsf
perl -i -p -e s/sub-01/sub-24/  sub-24_SS_run02.fsf
perl -i -p -e s/sub-01/sub-25/  sub-25_SS_run02.fsf
perl -i -p -e s/sub-01/sub-26/  sub-26_SS_run02.fsf
perl -i -p -e s/sub-01/sub-29/  sub-29_SS_run02.fsf
perl -i -p -e s/sub-05/sub-06/  sub-06_SS_run02.fsf
perl -i -p -e s/sub-05/sub-07/  sub-07_SS_run02.fsf
perl -i -p -e s/sub-05/sub-09/  sub-09_SS_run02.fsf
perl -i -p -e s/sub-05/sub-10/  sub-10_SS_run02.fsf
perl -i -p -e s/sub-05/sub-11/  sub-11_SS_run02.fsf
perl -i -p -e s/sub-05/sub-16/  sub-16_SS_run02.fsf
perl -i -p -e s/sub-05/sub-28/  sub-28_SS_run02.fsf


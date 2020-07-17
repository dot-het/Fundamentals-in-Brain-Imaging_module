#!/bin/bash

# Change to designs dir

cd /home/people/dxh814/replication/assessment_data/feat/1/designs/BART

# Copy over the saved model file for sub-01_BART

cp /home/people/dxh814/replication/assessment_data/feat/1/sub-01_BART.feat/design.fsf sub-01_BART.fsf


# Create model files for sub-02-29

for sub in sub-02 sub-03 sub-04 sub-05 sub-06 sub-07 sub-09 sub-10 sub-11 sub-12 sub-13 sub-14 sub-16 sub-17 sub-18 sub-20 sub-21 sub-23 sub-24 sub-25 sub-26 sub-28 sub-29
do
cp sub-01_BART.fsf ${sub}_BART.fsf
perl -i -p -e s/sub-01/${sub}/ ${sub}_BART.fsf
done


# Set the correct total volume numbers for each subjects

perl -i -p -e s/245/286/  sub-02_BART.fsf
perl -i -p -e s/245/236/  sub-03_BART.fsf
perl -i -p -e s/245/275/  sub-04_BART.fsf
perl -i -p -e s/245/276/  sub-05_BART.fsf
perl -i -p -e s/245/258/  sub-06_BART.fsf
perl -i -p -e s/245/246/  sub-07_BART.fsf
perl -i -p -e s/245/269/  sub-09_BART.fsf
perl -i -p -e s/245/269/  sub-10_BART.fsf
perl -i -p -e s/245/266/  sub-11_BART.fsf
perl -i -p -e s/245/215/  sub-12_BART.fsf
perl -i -p -e s/245/249/  sub-13_BART.fsf
perl -i -p -e s/245/272/  sub-14_BART.fsf
perl -i -p -e s/245/267/  sub-16_BART.fsf
perl -i -p -e s/245/255/  sub-17_BART.fsf
perl -i -p -e s/245/257/  sub-18_BART.fsf
perl -i -p -e s/245/263/  sub-20_BART.fsf
perl -i -p -e s/245/233/  sub-21_BART.fsf
perl -i -p -e s/245/276/  sub-23_BART.fsf
perl -i -p -e s/245/272/  sub-24_BART.fsf
perl -i -p -e s/245/222/  sub-25_BART.fsf
perl -i -p -e s/245/227/  sub-26_BART.fsf
perl -i -p -e s/245/234/  sub-28_BART.fsf
perl -i -p -e s/245/271/  sub-29_BART.fsf

# Fix the correct subject numbers  

perl -i -p -e s/sub-01/sub-02/  sub-02_BART.fsf
perl -i -p -e s/sub-01/sub-03/  sub-03_BART.fsf
perl -i -p -e s/sub-01/sub-04/  sub-04_BART.fsf
perl -i -p -e s/sub-01/sub-05/  sub-05_BART.fsf
perl -i -p -e s/sub-01/sub-06/  sub-06_BART.fsf
perl -i -p -e s/sub-01/sub-07/  sub-07_BART.fsf
perl -i -p -e s/sub-01/sub-09/  sub-09_BART.fsf
perl -i -p -e s/sub-01/sub-10/  sub-10_BART.fsf
perl -i -p -e s/sub-01/sub-11/  sub-11_BART.fsf
perl -i -p -e s/sub-01/sub-12/  sub-12_BART.fsf
perl -i -p -e s/sub-01/sub-13/  sub-13_BART.fsf
perl -i -p -e s/sub-01/sub-14/  sub-14_BART.fsf
perl -i -p -e s/sub-01/sub-16/  sub-16_BART.fsf
perl -i -p -e s/sub-01/sub-17/  sub-17_BART.fsf
perl -i -p -e s/sub-01/sub-18/  sub-18_BART.fsf
perl -i -p -e s/sub-01/sub-20/  sub-20_BART.fsf
perl -i -p -e s/sub-01/sub-21/  sub-21_BART.fsf
perl -i -p -e s/sub-01/sub-23/  sub-23_BART.fsf
perl -i -p -e s/sub-01/sub-24/  sub-24_BART.fsf
perl -i -p -e s/sub-01/sub-25/  sub-25_BART.fsf
perl -i -p -e s/sub-01/sub-26/  sub-26_BART.fsf
perl -i -p -e s/sub-01/sub-28/  sub-28_BART.fsf
perl -i -p -e s/sub-01/sub-29/  sub-29_BART.fsf





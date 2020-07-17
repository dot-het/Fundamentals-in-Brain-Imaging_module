#!/bin/bash

# Change to scripts directory
cd /home/people/dxh814/replication/assessment_data/scripts

# Open the extracted T1_brain.nii.gz and the uncroped T1.nii.gz images of each participant in Fsleyes
for sub in sub-01 sub-02 sub-03 sub-04 sub-05 sub-06 sub-07 sub-09 sub-10 sub-11 sub-12 sub-13 sub-14 sub-16 sub-17 sub-18 sub-20 sub-21 sub-23 sub-24 sub-25 sub-26 sub-28 sub-29
do
cd /home/people/dxh814/replication/assessment_data/${sub}/anat
echo ${sub}
fsleyes T1.nii.gz T1_brain.nii.gz 
done

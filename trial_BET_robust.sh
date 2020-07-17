#!/bin/bash

# Change to main assessment_data dir


cd /home/people/dxh814/replication/assessment_data/${sub}/anat

for sub in sub-01 sub-02 sub-03 sub-04 sub-05 sub-06 sub-07 sub-09 sub-10 sub-11 sub-12 sub-13 sub-14 sub-16 sub-17 sub-18 sub-20 sub-21 sub-23 sub-24 sub-25 sub-26 sub-28 sub-29
do
mv /home/people/dxh814/replication/assessment_data/${sub}/anat/T1_.nii.gz
mv /home/people/dxh814/replication/assessment_data/${sub}/anat/T1_brain_.nii.gz
#mv /home/people/dxh814/replication/assessment_data/${sub}/anat/T1.nii.gz /home/people/dxh814/replication/assessment_data/${sub}/anat/T1_.nii.gz

#mv /home/people/dxh814/replication/assessment_data/${sub}/anat/T1_brain.nii.gz /home/people/dxh814/replication/assessment_data/${sub}/anat/T1_brain_.nii.gz
done




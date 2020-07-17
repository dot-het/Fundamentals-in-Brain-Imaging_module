# Replication for DS009 analysis

## Replication steps

Describe here the exact steps that you took in order to replicate the analysis
described in Cohen's thesis.

Remember:

* be clear;
* justify all the analysis steps;



Replication of the fMRI data analysis (BART and SS task) presented in the PhD thesis of Jessica Cohen (University of California, Los Angeles).  

Materials and Methods for OpenfMRI ds009: The generality of self control -->   https://openfmri.org/media/ds000009/ds009_methods_0_CchSZHn.pdf

fMRI Data set  -->    https://openneuro.org/datasets/ds000009/versions/00002
					
RESEARCH REPORT 


REPLICATION:

## Step 0 -  Checking the acquired data

Firstly, I checked the total number of the images as 29 subjects participated in the MRI part but 5 of them have been excluded: sub-08, sub-15, sub-19, sub-22, sub-27. 
* BART run01: 24 
* SS   run01: 24
* SS   run02: 24
TOTAL:	      72 functional data
* T1 images: 24
* T2 images: 24


## Step 1 - Get permission for overwriting the files

The created shortcurt (symlink) from the /home/data/FBI/assessment directory to my /home/people/dxh814/replication directory is not allowing any changes in the original data (READ-ONLY files). Therefore, I created a new folder and copied the data to gain access for performing data processing.

cd /home/people/dxh814/replication
mkdir /home/people/dxh814/replication/assessment_data
cd /home/data/FBI/assessment
cp -r /home/data/FBI/assessment/ds000009.R2.0.3 /home/people/dxh814/replication/assessment_data

To prevent further errors due to mistyping the database name (ds000009.R2.0.3). I have copied the files again in the main assessment_data folder of my directory and deleted the folder and the content of it (ds000009.R2.0.3). I have not executed these steps in the terminal window, I have selected the files, press ctrl+c, then press ctrl+v in the ouput folder and shift + deleted the originally copied folder (ds000009.R2.0.3).

I wrote two scripts with the gedit text editor to examine the protocol information of the T1-weighted images and the functional images with the command of fslinfo. I ensured that all the written scripts are starting with: #!/bin/bash, then I saved the gedit.txt files in .sh format. These steps (using gedit text editor, giving #!/bin/bash as a starting line and saving the written files in .sh format) were applied to all the scripts that were created to replicate this analysis.

cd /home/people/dxh814/replication/assessment_data/scripts
chmod a+x fslinfocheck_T1.sh
chmod a+x fslinfocheck_func.sh

./fslinfocheck_T1.sh
./fslinfocheck_func.sh

The scripts can be found /home/people/dxh814/replication/assessment_data/scripts
I saved in a txt file the results of the fslinfo for the functional data to check the volumes number for the further analysis, it can be found: /home/people/dxh814/replication/assessment_data/scripts/fslinforesults_func.txt

## Step 2  - Visual inspection of anatomical brain images

Before begin the actual replication, I visually inspected the T1-weighted images of each subjects with fsleyes toolbox. I wrote a script, it can be found: /home/people/dxh814/replication/assessment_data/scripts/fsleyes_insp.sh 

cd /home/people/dxh814/replication/assessment_data/scripts
chmod a+x fsleyes_insp.sh 
./fsleyes_insp.sh 

Input images: cd /home/people/dxh814/replication/assessment_data/sub-xx/anat/sub-xx_T1w.nii.gz
It is important to ensure that the images are in the correct orientation: first-image (from left to right): sagittal, second-image: coronal, third-image: axial view.

## Step 3 - Fully automated brain extraction - BET

To replicate the following steps: 

"Imaging data were processed and analyzed using FSL 4.1 (FMRIB’s Software
Library, www.fmrib.ox.ac.uk/fsl). Steps included BET to extract the brain from the skull and McFLIRT for motion correction."

I extracted the brain from the skull using the BET tool to crop the brain and to  make the analysis more efficient in the next steps. To keep consistency across participants, I used the robustfov command to crop the FOV in the image, then ran the fully-automated BET. I created a script (BET_robust.sh), the script can be found here: 
/home/people/dxh814/replication/assessment_data/scripts/BET_robust.sh

cd /home/people/dxh814/replication/assessment_data/scripts
chmod a+x BET_robust.sh
./BET_robust.sh

The input images for BET are the T1-weighted images of each participant, they can be found: 
/home/people/dxh814/replication/assessment_data/sub-xx/anat/sub-xx_T1w.nii.gz

The output images: T1_brain.nii.gz were generated in each anat folders of sub-xx: 
/home/people/dxh814/replication/assessment_data/sub-xx/anat/T1_brain.nii.gz

The structure of each anat folders of sub-xx:
- sub-xx_inplaneT2.json
- sub-xx_inplaneT2.nii.gz*
- sub-xx_T1w.json
- sub-xx_T1w.nii.gz*
- T1_brain.nii.gz
- T1.nii.gz

The output images T1_brain.nii.gz have been visually inspected with Fsleyes, after BET to ensure the process was correctly applied. 

cd /home/people/dxh814/replication/assessment_data/scripts
chmod a+x fsleyes_insp_BET.sh 
./fsleyes_insp_BET.sh

It appears that the brain extraction resulted a bit bigger crop on the frontal region. Presumably, it could be the result of the robustfov command as it is moving the centre of FOV closer to the brain centre but it helps BET to gain a more consistent brain centre estimation. I tried to choose the brain centre manually for each participants, it sometimes resulted better extraction of the brain. However, the "missing" frontal lobe part seems to be consistent through the participants so I decided to keep the fully-automated BET versions. I  checked on the FSLwiki website that my decision is justified or not. Here is a direct quote from the FSL wiki website:

"Brain Extraction is a crucial step in many analysis pipelines - particularly for structural analysis involving segmentation, where an accurate brain extraction is important. It is also important for registration, but in this case the brain extraction does not have to be highly accurate, and small errors are fine." https://fsl.fmrib.ox.ac.uk/fslcourse/lectures/practicals/intro2/index.html 

To consider the fact that segmentation is not applied in this thesis, I have assumed that this could be accounted as a "small error". 


## Step 4 - First-level analysis/ Pre-processing

The analysis steps were similar for the different tasks so I am indicating with the following signs if it describes the SS_task analysis or BART.
SS_task: **SS_task**
BART: **BART**

The first-level analysis is mainly scripts-based for automatising the analysis although before the actual scripting, I used the GUI window of Feat (These steps are being described following down, after the instructions of scripting) to create some "design templates". The templates for the SS task were from sub-01 and sub-05, for the BART was sub-01.

**SS task**

It was necessary for running different designs for sub-01 and sub-05 as the timing files of the incorrect go responses of both runs (sub-xx_task-stopsignal_run-xx_label-goincorrect.txt) were missing for certain subjects apart from sub-05 (sub-09,sub-10,sub-11,sub-16), means this event (unsuccesful go responses) cannot be included. Some participants(sub-06, sub-07, sub-28) were just missing the second run of incorrect go responses of the SS task (sub-xx_task-stopsignal_run-02_label-goincorrect.txt).

"If there is no .txt file for a particular event, assume that there were not events of that type for the matching scanning run." Assessment_PartB_2019.pdf"

After sub-01_run01 & run02, sub-05_run01 & run02 were finished, I created a new folder (called: designs) in the new feat folder (that has been automatically created by Feat and named as the output given by me).

cd ~/replication/assessment_data/feat/1
mkdir ~/replication/assessment_data/feat/1/designs
mkdir ~/replication/assessment_data/feat/1/designs/BART
mkdir ~/replication/assessment_data/feat/1/designs/SS_task

~/replication/assessment_data/feat/1 : 1 indicates this is the first-level analysis
Then, I wrote a script for the first-level analysis of SS task_run01 and run02 by using the created design.fsf file of sub-01 and sub-05 and make it executable with typing chmod a+x in the terminal window. The scripts can be found: 

cd /home/people/dxh814/replication/assessment_data/feat/1/designs/SS_task
ls
create_SS_run01.sh
create_SS_run02.sh

cd /home/people/dxh814/replication/assessment_data/feat/1/designs/BART
ls
create_BART.sh


cd ~/replication/assessment_data/feat/1/designs/SS_task
chmod a+x create_SS_run01.sh
chmod a+x create_SS_run02.sh

cd ~/replication/assessment_data/feat/1/designs/BART
chmod a+x create_BART.sh


Following the thesis' preprocessing steps, I ran Feat to apply the first-level analysis, pull-down menu chose "First-level analysis" and on the second pull-down menu chose "FULL ANALYSIS".


Feat &

#Misc_Tab: I have accepted all the defaults.

#Data_Tab:
I chose from the pull-down menu the "First-level analysis" and "Full analyses".
I inserted the correct functional data for each participants and make sure the right run and the right task were chosen as the first-level analysis is applied to 
	task-stopsignal_run-01.nii.gz
	task-stopsignal_run-02.nii.gz
	task-balloonanalogrisktask_bold.nii.gz

"Select 4D data button" 

SS_task: /home/people/dxh814/replication/assessment_data/sub-xx/func/sub-xx_task-stopsignal_run-xx_bold.nii.gz


SS_task: I checked that the "Total volumes" were changed from 0 to 184 and ensure that this consistent through participants as I have previously checked this information with the fslinfo command.

Then, I gave a directory name in the output directory:

First run of SS task
/home/people/dxh814/replication/assessment_data/feat/1/sub-xx_SS_runxx
1 = first-level analysis
SS = stopsignal task
runxx = first or second run

The TR was automatically set to 2.000000s as Feat can read the TR from the header information. I set the High pass filter cutoff to 66s to replicate the following step: 

"highpass temporal filtering (Gaussian-weighted least-squares straight line fitting, with sigma = 33.0s)."


"Time-series statistical analysis was carried out using FILM (FMRIBs Improved Linear Model) with local autocorrelation correction after highpass temporal filtering (Gaussian-weighted least-squares straight line fitting, with sigma = 33.0s)."

#Pre-stats Tab:	

To replicate the following part: "For the first level analysis, images were spatially smoothed using a Gaussian kernel of FWHM 5 mm."

I ran two separate analysis with and without slice timing correction as the thesis was not fully clear that it was applied or not. 

If slice time correction was not applied, I ensured that it shows "None" on the Pres-stats Tab and double-check the spatial smoothing FWHM is set to 5 mm, everything else I left as default.

If slice time correction was applied, I set to "Interleaved" as the slices were acquired in interleaved order and double-check the spatial smoothing FWHM is set to 5 mm, everything else I left as default.

The results of the full analysis without slice time correction can be found here: /home/people/dxh814/replication/assessment_data/feat_nstc


#Registration Tab:

I chose to use the standard one-step registration of the EPI functional images to the matching structural images (/home/people/dxh814/assessment_data/sub-xx/anat/T1_brain.nii.gz). For the main structural image, I chose "Normal search" and "BBR" from the pull-down menu as BBR cost function tends to  to give substantially better registrations. For the Standard space image, I chose again "Normal search"  that is the most common general and gives the greatest flexibility (contains: translation, rotation, scaling, skewing) therefore more movement can be done.
 
   Main structural image:
  /home/people/dxh814/replication/assessment_data/sub-xx/anat/T1_brain
  Linear: Normal search and BBR
  Standard space:
  /usr/loca/fsl/data/standard/MNI152_T1_2mm_brain
  Linear: Normal search and 12 DOF

#Stats Tab:
I ticked the box: Use FILM prewhitening to replicate:

"Time-series statistical analysis was carried out using FILM (FMRIBs Improved Linear Model) with local autocorrelation correction."

Standard Motion Parameters was chosen from the pull-down menu of the motion parameters.

I left empty the "Voxelwise Confound List" and the "BETA Option: Apply external script".

Then, I pressed the "Full model setup" button to create the design matrixes to replicate:

"Statistical analysis was conducted using FEAT 5.98. The statistical models varied depending on the task. For the SS task, the model included events for successful go responses, successful stop responses, and unsuccessful stop responses. Incorrect and missed go trials were included in a nuisance regressor. All events began at fixation onset and lasted through the duration of the stimulus (1.5 seconds)."

#1. Full model setup for Subject: 01

I have increased the "Number of original EVs": 4 as the thesis says the modules included events for:
	1) successful go responses
	2) successful stop responses
	3) unsuccessful stop responses
	4) unsuccessful or missed go responses (nuisance regressors)

For "Basic shape", I chose: Custom (3 column format) with this option, it is possible to add the previously prepared event onset files from the functional data folder of each participants /home/people/dxh814/replication/assessment_data/sub-xx/func/
These steps have been applied for all the 4 EVs and on the purpose to replicate:

"Regressors of interest were created by convolving a delta function representing each event of interest with a canonical (double-gamma) hemodynamic response function (Woolrich et al., 2001). Parametric regressors were created by modulating the amplitude of a delta function using a demeaned version of the parameter of interest. In addition to regressors of interest, estimated motion parameters and their temporal derivatives (i.e., displacement) were included as nuisance regressors. Linear contrasts were performed for comparisons of interest."

See the EVs in more detailed below:

	1)EV name: c_go (successful go responses)
	Basic shape: Custom (3 column format)
	File name: 
/home/people/dxh814/replication/assessment_data/sub-xx/func/sub-xx_task-stopsignal_run-xx_label-gocorrect.txt 
	Convolution: Double-Gamma HRF
	Phase(s): 0
	I ticked the box "Add temporal derivative" and "Apply temporal filtering".

	2)EV name: c_stop (successful stop responses)
	Basic shape: Custom (3 column format)
	File name: 
/home/people/dxh814/replication/assessment_data/sub-xx/func/sub-xx_task-stopsignal_run-xx_label-stopcorrect.txt
	Convolution: Double-Gamma HRF
	Phase(s): 0
	I ticked the box "Add temporal derivative" and "Apply temporal filtering".

	3)EV name: ic_stop (unsuccessful stop responses)
	Basic shape: Custom (3 column format)
	File name: 
/home/people/dxh814/replication/assessment_data/sub-xx/func/sub-xx_task-stopsignal_run-xx_label-stopincorrect.txt
	Convolution: Double-Gamma HRF
	Phase(s): 0
	I ticked the box "Add temporal derivative" and "Apply temporal filtering".

	4)EV name: ic_go (unsuccessful go responses) NUISANCE REGRESSOR
	Basic shape: Custom (3 column format)
	File name: 
/home/people/dxh814/replication/assessment_data/sub-xx/func/sub-xx_task-stopsignal_run-xx_label-goincorrect.txt
	Convolution: Double-Gamma HRF
	Phase(s): 0
	I ticked the box "Add temporal derivative" and "Apply temporal filtering"

Contrasts & F-tests Tab:
"Setup contrasts & F-tests for" I have left on Original EVs. F-tests: 0 as on this stage there is no need for this statistical test. 
I added one contrast with the title of correct_stop vs correct_go  (as the main effect was comparing the successful stop responses to successful go responses) and for EV1 set -1.0 and for EV2 set 1.0. Probably, during the real data analyses, many more contrasts were applied but in our case to replicate the "main effect" I decided to use one contrast.

OC1 on correct_stop vs correct_go EV1 -1.0 EV2 1.0 EV3 0 EV4 0

I checked all the created design matrixes for each participants to ensure that it looks reasonable and it fits the experimental paradigm.
Checked the design efficiency tab too, to check required effect for the certain contrast. As if the required effect is too big, the efficiency is reduced.

#2. Full model setup for Subject: 05

I increased the "Number of original EVs": 3 due to the missing unsuccessful or missed go responses event txt file, nuisance regressors cannot be included. 
	1) successful go responses
	2) successful stop responses
	3) unsuccessful stop responses
	
	1)EV name: c_go (successful go responses)
	Basic shape: Custom (3 column format)
	File name: 
/home/people/dxh814/replication/assessment_data/sub-xx/func/sub-xx_task-stopsignal_run-xx_label-gocorrect.txt 
	Convolution: Double-Gamma HRF
	Phase(s): 0
	I have ticked the box "Add temporal derivative" and "Apply temporal filtering".

	2)EV name: c_stop (successful stop responses)
	Basic shape: Custom (3 column format)
	File name: 
/home/people/dxh814/replication/assessment_data/sub-xx/func/sub-xx_task-stopsignal_run-xx_label-stopcorrect.txt
	Convolution: Double-Gamma HRF
	Phase(s): 0
	I have ticked the box "Add temporal derivative" and "Apply temporal filtering".

	3)EV name: ic_stop (unsuccessful stop responses)
	Basic shape: Custom (3 column format)
	File name: 
/home/people/dxh814/replication/assessment_data/sub-xx/func/sub-xx_task-stopsignal_run-xx_label-stopincorrect.txt
	Convolution: Double-Gamma HRF
	Phase(s): 0
	I have ticked the box "Add temporal derivative" and "Apply temporal filtering".


Contrasts & F-tests Tab:
"Setup contrasts & F-tests for" I have left on Original EVs. F-tests: 0 as on this stage there is no need for this statistical test. 
I  added one contrast as we are interested in the "main effect" of the SS task with the title of correct_stop vs correct_go responses (as the main effect was comparing the successful responses) and for EV1 set -1.0 and for EV2 set 1.0 

OC1 on correct_stop vs correct_go EV1 -1.0 EV2 1.0 EV3 0 

I checked all the created design matrixes for each participants to ensure that it looks reasonable and it fits the experimental paradigm.
Checked the design efficiency tab too, to check required effect for the certain contrast. As if the required effect is too big, the efficiency is reduced.

**BART** 

For the BART, the same parameters were applied through tabs: Misc, Pre-stats, Post-stat as for the SS task apart from the design matrix on the Stas tabs therefore the following instructions are just covering the differences.

#Data Tab:
Input images:
Select 4D data: 
/home/people/dxh814/replication/assessment_data/sub-xx/func/sub-xx_task-balloonanalogrisktask_bold.nii.gz

Output: /home/people/dxh814/replication/assessment_data/feat/1/sub-xx_BART.feat

I checked that the "Total volumes" were changing from 0 to correct volumes number and ensure that this consistent through participants as this information previously checked the fslinfo command. Total volumes of each participants for the BART is different.


#1. Full model setup for Subject: 01

I have increased the "Number of original EVs": 4 as the thesis says the modules included events for:
	1) inflating the balloon
	2) the last inflation before and explosion
	3) cashing out
	4) balloon explosion
For "Basic shape", I have chosen: Custom (3 column format) with this option, it is possible to add the previously prepared event onset files from the functional data folder of each participants /home/people/dxh814/replication/assessment_data/sub-xx/func. These steps have been applied for all the 4 EVs and on the purpose to replicate:

"Regressors of interest were created by convolving a delta function representing each event of interest with a canonical (double-gamma) hemodynamic response function (Woolrich et al., 2001). Parametric regressors were created by modulating the amplitude of a delta function using a demeaned version of the parameter of interest. In addition to regressors of interest, estimated motion parameters and their temporal derivatives (i.e., displacement) were included as nuisance regressors. Linear contrasts were performed for comparisons of interest."

See the EVs in more detailed below:

	1)EV name: inflate (inflating the balloon (all but the last inflation of each trial)
	Basic shape: Custom (3 column format)
	File name:  /home/people/dxh814/replication/assessment_data/sub-xx/func/sub-xx_task-balloonanalogrisktask_label-inflate.txt 
	Convolution: Dcashouble-Gamma HRF
	Phase(s): 0
	I ticked the box "Add temporal derivative" and "Apply temporal filtering".

	2)EV name: b_exp (the last inflation before an explosion)
	Basic shape: Custom (3 column format)
	File name: /home/people/dxh814/replication/assessment_data/sub-xx/func/sub- xx_task-balloonanalogrisktask_label-beforeexplode.txt
	Convolution: Double-Gamma HRF
	Phase(s): 0
	I ticked the box "Add temporal derivative" and "Apply temporal filtering".

	3)EV name: cash_out (cashing out)
	Basic shape: Custom (3 column format)
	File name: /home/people/dxh814/replication/assessment_data/sub-xx/func/sub-xx_task-balloonanalogrisktask_label-cashout.txt
	Convolution: Double-Gamma HRF
	Phase(s): 0
	I ticked the box "Add temporal derivative" and "Apply temporal filtering".

	4)EV name: exp (balloon explosion) 
	Basic shape: Custom (3 column format)
	File name: /home/people/dxh814/replication/assessment_data/sub-xx/func/sub-xx_task-balloonanalogrisktask_label-explode.txt
	Convolution: Double-Gamma HRF
	Phase(s): 0
	I ticked the box "Add temporal derivative" and "Apply temporal filtering"

Contrasts & F-tests Tab:
"Setup contrasts & F-tests for" I have left on Original EVs. F-tests: 0 as on this stage there is no need for this statistical test. 
I added one contrast with the title of cash_out vs inflate  (as the main effect was comparing the cashing-out and inflating the balloon) and for EV1 set -1.0 and for EV3 set 1.0. Probably, during the real data analyses, they have applied many more contrasts but in our case to replicate the "main effect" I just gave one contrast.

OC1 on cashout vs inflate EV1 -1.0 EV2 0.0 EV3 1.0 EV4 0

I checked all the created design matrixes for each participants to ensure that it looks reasonable and it fits the experimental paragdigm.
Checked the design efficiency tab too, to check required effect for the certain contrast. As if the required effect is too big, the efficiency is reduced.

Outputs can be found: 
/home/people/dxh814/replication/assessment_data/feat/1/sub-xx_BART.feat

The following steps were applied for both tasks:

#Post-stats Tab:
I have changed the thresholding to Uncorrected with the p of 0.05 (default) as no statistical comparison has been made at this stage.

Outputs can be found: 
/home/people/dxh814/replication/assessment_data/feat/1/sub-xx_SS_runxx.feat
/home/people/dxh814/replication/assessment_data/feat/1/sub-xx_BART.feat

The structure of each feat folders of sub-xx after the first-level analysis:

- absbrainthresh.txt
- cluster_mask_zstat1.nii.gz
- cluster_zstat1.html
- cluster_zstat1_std.html
- cluster_zstat1_std.txt
- cluster_zstat1.txt
- confoundevs.txt
custom_timing_files/
- design.con
- design_cov.png
- design_cov.ppm
- design.frf
- design.fsf
- design.mat
- design.min
- design.png
- design.ppm
- design.trg
- example_func.nii.gz
.files/
- filtered_func_data.nii.gz
fontconfig/
- lmax_zstat1_std.txt
- lmax_zstat1.txt
logs/
- mask.nii.gz
mc/
- mean_func.nii.gz
- .ramp.gif
reg/
- rendered_thresh_zstat1.nii.gz
- rendered_thresh_zstat1.png
- report.html
- report_log.html
- report_poststats.html
- report_prestats.html
- report_reg.html
- report_stats.html
- report_unwarp.html
stats/
- thresh_zstat1.nii.gz
- thresh_zstat1.vol
tsplot/


After the analysis was finished, each tabs of the reports (Registration, Pre-stats, Stats, Post-stats) for all subjects have been checked. The quality of the registration on the Registration tab, the McFLIRT motion correction on the Pre-stats tab and examine how the created design fits the data on Post-stats tab. To look in more detail, I opened the filtered functional files with fsleyes from the freshly generated feat folders. Therefore, I changed the folder location to each participants SS task xx run feat folder, then opened the filtered functional files.

cd /home/people/dxh814/replication/assessment_data/feat/1/sub-xx_SS_runxx.feat

fsleyes filtered_func_data.nii.gz

cd /home/people/dxh814/replication/assessment_data/feat/1/sub-xx_BART.feat

fsleyes filtered_func_data.nii.gz

Then, I added each participants' thresh_zstat1 image (changed the colour scale to Red-yellow) and used the movie mode to identify the areas that has been stimulated.

To run Feat automatically, I created 3 separate scripts, saved them in the corresponding folders and make them executable with typing chmod a+x. The scripts contain comment about the steps were necessary to make the automation possible, therefore I am not including here.

Before, I ran feat script from the terminal window, I ensured all the created design.fsf files are correct, containing the correct subjects number, timing files and volume number.

cd /home/people/dxh814/replication/assessment_data/feat/1/designs/BART/feat_BART.sh
chmod a+x feat_BART.sh

cd /home/people/dxh814/replication/assessment_data/feat/1/designs/SS_task/feat_SS_run01.sh
chmod a+x feat_SS_01.sh
chmod a+x feat_SS_02.sh


Executing the first-level analysis automatically for every participants, I typed in the terminal window :

cd /home/people/dxh814/replication/assessment_data/feat/1/designs/BART
./feat_BART.sh

cd /home/people/dxh814/replication/assessment_data/feat/1/designs/SS_task
./feat_SS_01.sh
./feat_SS_02.sh


## Step 5 - Second-level analysis

**SS_task**
	
For this level, I chose to perform all-in-one method second level analysis. I changed the pull-down menu from "First-level analysis" to "Higher-level analysis" and set "Inputs are lower-level FEAT directories". Then, I changed the inputs to 48 as 24 subjects have performed the SS task for 2 runs. 2 x 24 = 48 functional images. I selected the FEAT directories by adding all the files in the correct logical order:

/home/people/dxh814/replication/assessment_data/feat/1/sub-01_SS_run01.feat
/home/people/dxh814/replication/assessment_data/feat/1/sub-01_SS_run02.feat
/home/people/dxh814/replication/assessment_data/feat/1/sub-02_SS_run01.feat
/home/people/dxh814/replication/assessment_data/feat/1/sub-02_SS_run02.feat
.
.
.
.
/home/people/dxh814/replication/assessment_data/feat/1/sub-29_SS_run01.feat
/home/people/dxh814/replication/assessment_data/feat/1/sub-29_SS_run02.feat

After added all the files, I chose an output directory:
/home/people/dxh814/replication/assessment_data/feat/2/SS_task.gfeat


On the Stas tab I chosen "Fixed effects" from the pull down menu to replicate: 

"For the two tasks that had more than one run (SS and ER), data were combined across the two runs using a fixed effects model, and then modeled using mixed effects at the group level with FSL’s FLAME model (Stage 1 only)."

I used the "Full model setup" and increased the total number of main EVs to 24 as they are corresponding to the 24 participants in the experiment. I put number 1 in any row of the EV column if the scan is matching the participant. Then on the Contrast & F-tests tab, I changed the number of the contrasts to 24 (the number of the participants) changed each title of the contrasts to the corresponding subjects (C1= sub-01, C2=sub-2 ..., C24=sub-29) and put number 1 in any row of the EV column if it was matched the participants. This step is important to compute the mean between the 2 scans within each subject to obtain the average of activation from both scans. I accepted everything else as default and run it. 

Poststats Tab:

I used Cluster thresholding, set the z threshold: 3.1 and ensured the Cluster P threshold is set to 0.05. I left the rest of the options as default on the tab.

Output:

/home/people/dxh814/replication/assessment_data/feat/2/SS_task.gfeat

## Step 6 - Calculating the demeaned number of pumps BART

With WinSCP, I copied each events files (.tsv) of the participants to my computer: 

/home/people/dxh814/replication/assessment_data/sub-xx/func/sub-xx_task-balloonanalogrisktask_events.tsv

I opened each events.tsv files in Excel for filtering out the data to show "b" in the column of "button_pressed", as b indicates when the participants pumped the balloon. Then, I counted for each participants how many times b occurs during their run. After this, I calculated the group means of the total number of pumps: 173.91666. To calculate the mean-centre, I subtracted this group mean from the total number of pumps of each participants. To ensure that the calculation was correct, I averaged the calculated demeaned values and check the result is zero.
I saved the calculated demeaned values and the total number of pump in a txt file, and copied to my pbic directory, can be found: 
/home/people/dxh814/replication/assessment_data/demeaned_EVs/BART_pumps.txt


## Step 7 - Calculating the demeaned SSRT

With WinSCP, I copied each events files of the participants to my computer:

/home/people/dxh814/replication/assessment_data/sub-xx/func/sub-xx_task-stopsignal_run-01_events.tsv
/home/people/dxh814/replication/assessment_data/sub-xx/func/sub-xx_task-stopsignal_run-02_events.tsv

I opened each files in Excel,and counted the following parameters for each subjects:
	- Total STOP responses
	- Unsuccesful STOP responses
	- Succesful GO responses
	- Mean of Stop-Signal Delay (SSD) for STOP responses

To replicate the following part:
"To calculate SSRT, first all correct RTs were arranged in an assumption-free distribution in ascending order. Then the proportion of failed inhibition (i.e., the proportion of stop trials on which the participant responded) was determined. The RT corresponding to that proportion was computed (i.e.,if failed inhibition was .55, the RT corresponding to 55% of the area under the RT distribution curve): the quantileRT. SSRT was calculated as the difference
between the quantileRT and the average SSD."

Fist, I sorted the data by setting the ReactionTime column in ASCENDING order.
Then, I filtered the data to show the STOP responses (in the trial_type column), and counted how many STOP responses occured during each runs. 
Then, I filtered the data to show the UNSUCCESFUL STOP responses in the TrialOutcome column (while the STOP responses filter is still on), and counted how many times they occur.
I set back the filter to show all the STOP responses and calculated the mean of the SSD for STOP responses.
Finally, I filtered the data to present the SUCCESFUL GO responses in the trial_type column, set a filter to the TrialOutcome column to sort out the unsuccesful or junk GO responses, and took a note of the occurence.

These steps were essential to calculate:
	1. proprotion of failed inhibition, is the ratio of UNSUCCESFUL STOP responses / total number of STOP responses.
	2. quantileRT was calculated by multiplying the calculated propotion of failed inhibiton and the total number of succesful GO respones
	3. The quiantileRT shows the median values of the RT of the succesful GO responses for each participant.
	4. SSRT was calculated by subtracting the average SSD from this previously calculated median RT (the median value of RT of the succesful GO responses that is corresponding to the quantileRT.  

Example: 
sub-01_run01
Total number of STOP responses:32
Total number of UNSUCCESFUL STOP responses:16
Propotion of failed inhibiton: 0.5 = (16/32)
Total number of SUCCESFUL GO responsesos:95	
qRT value:47.5 = (95 * 0.5)
SSD mean: 0.3451930487
The corresponding RT for the qRT value:	0.509595593
SSRT: 0.164402544 = (0.509595593 - 0.3451930487)

DEMEANING:
First, I averaged the two runs of SS task for each participants. Then, I calculated the mean of the SSRTs, the calculated mean was substracted from the individual subjects SSRT.To ensure that the calculation was correct, I averaged the calculated demeaned values and check the result is zero.

I copied the created excel file from my personal laptop to the pbic directory of mine and I saved the calculated demeaned values in a txt file, can be found: 
/home/people/dxh814/replication/assessment_data/demeaned_EVs/SSRT.txt
/home/people/dxh814/replication/assessment_data/demeaned_EVs/SSRT.xlsx

## Step 8 - Third-level analysis

This part of the analysis is the same for SS task and BART, the only differences are the inputs files, outputs and the created design matrix on the Stats tab under the Full model setup.
To combine the data across participants from the all-in-one second analysis, I ran Feat, chose the "Higher-level analysis" again. I  changed the default setting from "Input are lower-level FEAT directories" to "Inputs are 3D cope images from FEAT directories", increase the inputs to be 24 (because of the 24 participants) and press "Select cope images"

**SS_task** 

/home/people/dxh814/replication/assessment_data/feat/2/SS_task.gfeat/cope1.feat/stats/cope1.nii.gz
/home/people/dxh814/replication/assessment_data/feat/2/SS_task.gfeat/cope1.feat/stats/cope2.nii.gz
.
.
.
/home/people/dxh814/replication/assessment_data/feat/2/SS_task.gfeat/cope1.feat/stats/cope24.nii.gz


Then, I gave the following output directory 
/home/people/dxh814/replication/assessment_data/feat/3/SS_task.gfeat

Just for clarification the copexx numbers are not equal for the participants number as it is just the order of data processing number (1-24).

**BART**

/home/people/dxh814/replication/assessment_data/feat/1/sub-01_BART.feat
.
.
.
/home/people/dxh814/replication/assessment_data/feat/1/sub-29_BART.feat

Then, I gave the following output directory 
/home/people/dxh814/replication/assessment_data/feat/3/BART.gfeat

Misc Tab: I left everything as default.

On the Stats tab, I chose from the top pull down menu: "Mixed Effects: Flame 1" and ticked on the box "Use automatic outlier de-weighting" to replicate the following part of the thesis:

"For the two tasks that had more than one run (SS and ER), data were com-
bined across the two runs using a fixed effects model, and then modeled using mixed effects at the group level with FSL’s FLAME model (Stage 1 only).The model for each task included a regressor modeling mean activity and demeaned regressors for SSRT (SS), number of pumps (BART), k (TD), and amount of reported regulation (ER). Outlier deweighting was performed using a mixture modeling approach (Woolrich, 2008)." 

Full modell setup Tab:

I increased the total number of EVs to 2, EV1 was named it cash_out vs inflate and set 1 for all inputs in the whole column. EV2 was named as demeaned_EVs, and I typed in the corresponding mean-centred value. On the Contrast tab, I used two contrast and named it as group mean and demeaned EVs.

**BART**
EV1  	EV2			Contrast tab:  C1 EV1 1 EV2 0
1	-10.9167			       C2 EV1 0 EV2 1
1	27.0833
1	-6.9167
1	9.0833
1	7.0833
1	10.0833
1	3.0833
1	7.0833
1	3.0833
1	12.0833
1	-31.9167
1	0.0833
1	12.0833
1	16.0833
1	-20.9167
1	19.0833
1	10.0833
1	-25.9167
1	5.0833
1	11.0833
1	-35.9167
1	-13.9167
1	-17.9167
1	12.0833

**SS_task**
EV1	EV2			contrast tab: C1 EV1 1 EV2 0
1	-0.0121				      C2 EV1 0 EV2 1
1	0.0590
1	-0.0355
1	-0.0537
1	-0.0045
1	0.0740
1	-0.0091
1	0.0379
1	0.0189
1	-0.0339
1	0.0358
1	-0.0233
1	-0.0690
1	-0.0406
1	0.1926
1	-0.0464
1	-0.0392
1	0.0015
1	-0.0116
1	-0.0368
1	0.0919
1	-0.0095
1	-0.0362
1	-0.0503



Poststats Tab:

I used Cluster thresholding, set the z threshold: 2.3 and ensured the Cluster P threshold is set to 0.05. I left the rest of the options as default on the tab.

"Outlier deweighting was performed using a mixture modeling approach (Woolrich, 2008). Results were threshold at a whole-brain level using cluster-based Gaussian random field theory, with a cluster-forming threshold of z > 2.3 and a whole-brain corrected cluster significance level of p < .05 unless otherwise noted in the text."

Output images can be found:

/home/people/dxh814/replication/assessment_data/feat/3/BART.gfeat
/home/people/dxh814/replication/assessment_data/feat/3/SS_task.gfeat


## The location of replication files:

After the two full analysis (from first to third level) were finished for the slice time corrected and the non slice time corrected runs, I compared the coordinates and the max z-score of the results with the reported data in the thesis 
(txt files can be found: /home/people/dxh814/replication/assessment_data/feat/3/comp_3rdBART.txt, /home/people/dxh814/replication/assessment_data/feat/3/comp_3rdSS.txt) and visually inspected it with fsleyes too. When the interleaved slice time correction was applied, the data seems to give a better fit to the reported ones therefore I decided to keep the slice time corrected analysis as the main results of my replication. 

* t-statistic map for main effect of SS task (group mean):
/home/people/dxh814/replication/assessment_data/feat/3/SS_task.gfeat/cope1.feat/stats/tstat1.nii.gz

* thresholded z-statistic map for main effect of SS task (group mean):
/home/people/dxh814/replication/assessment_data/feat/3/SS_task.gfeat/cope1.feat/thresh_zstat1.nii.gz

* t-statistic map for main effect of BART task (group mean):
/home/people/dxh814/replication/assessment_data/feat/3/BART.gfeat/cope1.feat/stats/tstat1.nii.gz

* thresholded z-statistic map for main effect of BART task (group mean):
/home/people/dxh814/replication/assessment_data/feat/3/BART.gfeat/cope1.feat/thresh_zstat1.nii.gz



##Step 10 - Identifying the common voxels that have a statistically convincing effect

First, I typed the fslmaths in the terminal window to know more information about the command and understand how the command works, which operators are supposed to use. After the consideration of the operators, I decided to use the already thresholded zstat images of each task, as it was stated in the assessment instruction pdf  means and use the following operators of fslmaths: 
-bin   bin as it means use (current image>0) to binarise
-add   add following input to current image
-sub   subtract following input from current image

I created a new folder in the third-level feat folder, called activity

cd /home/people/dxh814/replication/assessment_data/feat/3
mkdir activity

I changed the directory location to the each tasks (cope1.feat folder), then copied and renamed the thresh_zstat1.nii.gz files and type the fslmaths command in the correct way (ensure the right order of the input files, operators and output files. 

cd /home/people/dxh814/replication/assessment_data/feat/3/BART.gfeat/cope1.feat
cp thresh_zstat1.nii.gz /home/people/dxh814/replication/assessment_data/feat/3/activity/BART_thresh_zstat1

cd /home/people/dxh814/replication/assessment_data/feat/3/SS_task.gfeat/cope1.feat
cp thresh_zstat1.nii.gz /home/people/dxh814/replication/assessment_data/feat/3/activity/SS_thresh_zstat1


fslmaths [-dt <datatype>] <first_input> [operations and inputs] <output> [-odt <datatype>]

As input files, I used the thresh_zstat1 image of each participants for each tasks and use as an output:  I checked the results with fsleyes. 

pwd
/home/people/dxh814/replication/assessment_data/feat/3/activity

#Add the two current images together to gain an all in one activation map and binarise the combination of the two image activation maps, the voxel intensity of the image contains just the value 1 as the two input images are representing the activated regions above a certain threshhold (z > 2.3) so the activated regions voxel intensity after the binarisation is 1

fslmaths fslmaths BART_threshzstat1 -add SS_threshzstat1 -bin comb_im_bin
 
#Check the output
fsleyes comb_im_bin
fslview_deprecated comb_im_bin	

#Create a binarised mask of the activation of BART		
fslmaths BART_threshzstat1.nii.gz -bin BART_threshz_mask.nii.gz	

#Binarise and create a maskk of the activation of SS	
fslmaths SS_threshzstat1.nii.gz -bin SS_threshz_mask.nii.gz

#Combine the two binarised activation masks, the voxel intensities of the output image is not just between 0-1 as the images that were added together, already had voxel intensities between 0-1
fslmaths BART_threshz_mask.nii.gz -add SS_threshz_mask.nii.gz comb_mask

#Check the ouput
fsleyes comb_mask
fslview_deprecated comb_mask

#Subtract the binarised all in one activation map (voxel intensity is all over 1) from the activation map of the tasks that has voxel intensity between 1-2
fslmaths comb_mask -sub comb_bin comb_int_1
fsleyes comb_int_1
fslview_deprecated comb_int_1

The ouput image shows the common activation regions and indicates as voxel intensity 1 the rest of the image contains 0
The output images can be found: /home/people/dxh814/replication/assessment_data/feat/3/activity

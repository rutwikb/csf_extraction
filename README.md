# csf_extraction
pipeline to run bash and matlab scripts for csf extraction
May 2017- STOP-PD & MRS data analysis
Rutwik Bangali: rutwik.bangali@mail.utoronto.ca

Overview
-------------------------------------------------------------------
Analyzing the STOPPD data found in data2.0. Under STOPPD/data/Resources
there are multiple subject folders from 4 different sites:
1. camh (3T GE scanner)
2. U Mass (3T phillips scanner)
3. U Pittsburgh (3T siemens scanner)
4. Nathan Kline/Cornell (3T siemens scanner)

LC model is a software used for MRS, and it has already been run on these subjects. The scanner files are located in the subject folders.

The scripts in this folder are to generate a csf fraction in order to normalize the MRS data.


-------------------------------------------------------------------
- the folder labelled 'old' can be safely ignored, it may even be    	deleted at some point once it is certain that it serves no purpose.

- The scripts folder contains all scripts that are necessary. Before running any of these scripts the data must be prepped. The paths must also be changed, these are currently hardcoded.

steps:
-copy all subject folders w/ MRS files to a folder.
-change paths in the script labelled "large_script_2" as necessary
- run large_script_2


- in the 'software folder', there are essential programs that you must copy over to your folder. SPM 8 and Gannet 2.0 must be added to matlab path in order for the script to work

- after adding these to path, open the matlab script "matlab1.m".
- edit the paths in this script as required
-run the script, the results should all be saved in dcmdir2. This includes jpegs of the voxel and the nifti files. 

-new_tests is the folder where all the results are stored of the subjects that I have run.

-Refer to the given_data folder for detailed instructions by Dr.Sofia Chavez.

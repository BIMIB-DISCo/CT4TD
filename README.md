# CT4TD
Control Theory for Therapy Design
----------------------------------

The increasing availability of experimental data on cancer patients and the growth of computing power are paving the way for an effective application of control theory to precision medicine.

We introduce the CT4TD (Control Theory for Therapy Design) theoretical framework, which combines optimal control theory and population dynamics to deliver patient-specific therapeutic strategies, by translating the physiological features of individuals into personalized pharmacokinetics and pharmacodynamics models. 

With CT4TD it is possible to identify optimized therapies at diagnosis, aimed at reaching selected drug concentration, or to adjust existing therapeutic regimes, when longitudinal data on disease progression are available.  

A preprint of the article is available at this link: 

This repositories contains script and data to reproduced the case study discussed in the article. 
In particular, we apply CT4TD to the case of Imatinib administration in Chronic Myeloid Leukemia and show that tailored therapies display remarkable advantages in terms of efficacy and reduced toxicity.

----------------------------------
Instructions to reproduce the case study presented in the paper
----------------------------------

**Software Requiremtents**

- Python 3.5+ (may work with older versions of the 3.0 branch, but not with 2.7+ branch)
- Paramiko 2.1.2+ (may work with older versions, but is unsupported)
- numpy 1.12.0+ (may work with older versions, but is unsupported)
- tkinter
- matplotlib 2.2.2+ (may work with older versions, but is unsupported)
- scipy 1.0.1+ (may work with older versions, but is unsupported)
-  matlab.engine (for fomevaluation = 3, see /Config/Client_config/chopped.txt file and https://it.mathworks.com/help/matlab/matlab_external/install-the-matlab-engine-for-python.html   for more informations)
- Mathematica 9.0+ (may work with older versions)
- Stable internet connection


**Instructions for a single new analysis and optimization** 

Open Folder Single-analysis, and follow the steps

Step 1:

	-Open Settings.txt in the folder data-analysis and insert the demographic factor of the patient
	(BW[kg],Age[years],Sex[1=Male,0=Female]). 
	If you do not change this file the program will use the average demographic parameters (BW= 70 Kg, Age=50 years, Sex= Male) and
	the number of doses per day.
	Note that in this file is necessary to specify the working scenario, if you select working scenario 1 then skip the next step.
	
	- If you known the experimental results of the dynamics of the tumor burden insert them in a Excel file named 
	Data-TB.xls,note that you have to insert the times (in months) in the first row and the data of tumor burden in the second row,
	these data must be inserted in percentile of cells with BCR-ABL mutation respect the total.
	  
	-Open single-analysis.nb  as a mathematica notebook (http://www.wolfram.com/?source=nav) then click Evaluation ->
	Evaluate Notebook to run the analysis. You will obtain the PK personal parameters (file personal.dat) and in if TB data are 
	present also the PD personalized parameters.
Step 2:

	- In the main folder lauch script_Step2.py and follow instructions on screen.
Step 3:

	-Extract results of optimization. You could find them in the folder RedCRAB/userstats/job_#job_id#/Opti_pulses.
	 #job_id# is the name of the job.
	 The standard name for such file is SI=XX_Feval_no=XX_FOM=XXXXXXXX.txt
	-Put the .txt file into the folder \plot.
	-Modify parameters of \plot\Main_so.m with the same parameters of optimization (e.g., CL,V, number of doses). These     
	parameters are in file \data-analysis\personal.dat 50in this order (Cl,V,K_a,EC_{50}).
	-Modify \plot\Theoretical_Interface.m with the name of the file SI=XX_Feval_no=XX_FOM=XXXXXXXX.txt and lauch the 
	 script.
	-Now,  plots should pop-up and in the folder plot there are the data files with results, in particular in file  
	n_doses.txt will contains the doses and the time schedule.
	
	
	
	
	
If you want to replicate the results of the paper applying CT4TD to the same data set, you could find the used data in the file "Data used for michor Nature paper 2005.xls". You have to copy the time evolution of ONE  tumour burden in the file "Data-TB.xls" and put the demographic factors of the patient in the file "Settings.txt".

NOTE: it is possible that the optimization does not give the same result, this is due to the behavior of REDCRAB (it is intrisically random) or because you choose other values for the number of Fourier basis or the Super Iteration  inside the Cfg.txt file.

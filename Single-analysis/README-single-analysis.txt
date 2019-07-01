	
	Step 1:
	-Open Settings.txt in the folder data-analysis\
	- If you known the experimental results of the dynamics of the tumor burden insert them in a Excel file named Data-TB.xls,
	note that you have to insert the times in the first row and the data of tomur burden in the second row, these data must be inserted in percentile
	-OPEN single-analysis.nb  as a mathematica notebook (http://www.wolfram.com/?source=nav)
		than click Evaluation > Evaluate Notebook to run the analysis.
		
		
		
	Step 2:
	- In the main folder lauch script_Step2.py and follow instructons on screen.
	
	Step 3:
	- Extract results of optimization. You could find it in RedCRAB/userstats/job_#job_id#/Opti_pulses.
	#job_id# is the name of the job.
	The standard name for such file is SI=XX_Feval_no=XX_FOM=XXXXXXXX.txt
	-Put the .txt file into the folder plot
	-Modify parameters of Main_so.m with the same parameters of optimization (e.g., CL,V, number of doses,..)
	-Modify Theoretical_Interface.m with the name of the file SI=XX_Feval_no=XX_FOM=XXXXXXXX.txt and lauch the 
	 script
	-Now  plots should pop-up and in the folder plot there are the files, in particular in file n_doses.txt will contains
	the doses and the time schedule.
	
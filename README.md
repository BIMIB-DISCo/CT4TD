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
Instructions to reproduce the case study

In the folders you could find the programs to generate the figures of main text and of SI, the data analysis and the RedCrab suite.

To run an optimization open the "REDCRAB/RedCRAB_Client" folder and read the quick start guide to configure it. 
You could modify PK/PD parameters, number of doses and functional costs inside the MATLAB program Main_so.m. Then, finally lauch RedCrab.py to start.

After the optimization is ended, take the file SI=*** (read quick start guide to find it) into the folder "to-extract-results" and run Theoretical_interface.m (NOTE you need to modify Main_so.m with same parameters and number of doses of the Main_so.m in the folder RedCRAB_Client) and you will obtain a file n_doses.txt, wich contains the time schedule and the dosage

To obtain figures of  optimization you have to put inside doses***.txt file the doses present in the file n_doses.txt (this is for the folder FIG3, FIG5 and FIG6 folder)

To run the DATA-ANALYSIS just run the Mathematica notebook

To obtain the personalized PD from results of data analysis just run the Mathematica notebook in the folder FIG2 




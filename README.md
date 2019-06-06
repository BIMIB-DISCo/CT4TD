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
- Matlab (any version)
- Mathematica (any version)
- Python (>= 2.0)

**Instructions** 
The various folders of this GitHub repository include the scripts to generate the figures of the main text and of the SI of the article, as well as to perform the longitudinal data analysis and to launch the RedCrab suite. Please follow the following steps. 

1) In order to perform the optimization procedure, one should first access to the "REDCRAB/RedCRAB_Client" folder and follow the instructions contained in the readme file, which include a quick start guide oncerning the pipeline configuration. 
It is possible to set the parameters of the PK/PD models, the number of doses and to define distinct functional costs by modifying the MATLAB script named "Main_so.m". 
It is then possible to launch the Python script named "RedCrab.py".

2) After completing the optimization procedure, please move the file named SI=*** (please refer to the quick start guide on how finding it) into the folder named "to-extract-results" and successively run the Matlab script "Theoretical_interface.m" (NOTE: you will need to modify the "Main_so.m" script with same parameters and number of doses of the "Main_so.m" script included in the RedCRAB_Client floder).
This will produce a file named "n_doses.txt", wich contains the time schedule and the dosage of the optimized therapy

3) To generate the figures you have to write into the file named doses***.txt file the content (i.e., the dosage) of the file "n_doses.txt". The procedure must be repeated for folders: "FIG3", "FIG5" and "FIG6" folder. 
You can successively run the Mathematica notebook included in the folder corresponding to the Figure number. 

4) To run the analysis of the tumor burden variation longitudinal data, please run the Mathematica notebook included in folder: 

5) Finally, to obtain the personalized PD parameters as derived by the data analysis procedure, please run the Mathematica notebook included in the folder "FIG2".  




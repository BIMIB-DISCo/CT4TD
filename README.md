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
- matplotlib 2.2.2+ (may work with older versions, but is unsupported)
- scipy 1.0.1+ (may work with older versions, but is unsupported)
-  matlab.engine (for fomevaluation = 3, see /Config/Client_config/chopped.txt file and https://it.mathworks.com/help/matlab/matlab_external/install-the-matlab-engine-for-python.html   for more informations)
- Mathematica 9.0+ (may work with older versions)
- Stable internet connection


**Instructions** 

The various folders of this GitHub repository include the scripts to generate the figures of the main text and of the SI of the article, as well as to perform the longitudinal data analysis and to launch the RedCrab suite. Please follow the following steps. 

1) **Data analysis** 
For any step, please refer to the readme included in the corresponding folders. 
To run the analysis of the tumor burden variation longitudinal data (original dataset from: Michor, F., et al. "Dynamics of chronic myeloid leukaemia." Nature 435.7046 (2005): 1267.), please run the Mathematica notebook named "Linear-analysis.nb" included in folder: "DATA-ANALISYS". 

2) **Patient-specific PD parameters** 
To obtain the personalized PD parameters as derived from the data analysis procedure, please run the Mathematica notebook "evaluation-of-EC50.nb" included in the folder "FIG4".  Note that you have to insert the values of \beta (the value of the decay of cancer stem cells) obtained by data analysis and personalized PK parameters inside the file "personal-parameters.txt" (refer to "Legend-personal-parameters")

3) **Optimization** 

A) In order to perform the optimization procedure, one should first access to the "REDCRAB/RedCRAB_Client" folder and follow the instructions contained in the "QuickstartGuide.txt"  file, which include a guide concerning the client configuration. 
It is possible to set the parameters of the PK/PD models, the number of doses and to define distinct functional costs by modifying the MATLAB script named "Main_so.m". 
It is then possible to launch the Python script named "RedCrab.py".

B) After completing the optimization procedure, please move the file named SI=*** (please refer to the "QuickstartGuide.txt" inside folder RedCRAB_Client on how finding it) into the folder named "to-extract-results" and successively run the Matlab script "Theoretical_interface.m" (NOTE: you will need to modify the path in "Theoretical_interface.m" and the "Main_so.m" script with same parameters and number of doses of the "Main_so.m" script included in the RedCRAB_Client floder).
This will produce a file named "n_doses.txt", wich contains the time schedule and the dosage of the optimized therapy

4) **Figures**  
To generate the figures you will finally have to write (copy) the content (i.e., the dosage) of the file "n_doses.txt" into the file named doses***.txt file. 
The procedure must be repeated for folders: "FIG3", "FIG5" and "FIG6" folder. 
You can successively run the Mathematica notebooks included in the folder corresponding to the Figure number. 
To obtain Fig. 2 just run the Mathematica notebook "simulation-of-all-pk.nb" in the folder "FIG2" 
For all cases, you have to insert the values of \beta (the value of the decay of cancer stem cells) and personalized PK parameters inside the file "personal-parameters.txt" (refer to "Legend-personal-parameters")




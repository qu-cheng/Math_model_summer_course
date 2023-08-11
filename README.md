---
title: "Labs"
author: "Qu Cheng"
date: "`r Sys.Date()`"
output:
  html_document:
    df_print: paged
---



*Adapted from [Infectious Disease Modelling Specialization on Coursera](https://www.coursera.org/specializations/infectious-disease-modelling)*


# Install R and Rstudio  
* Install R from: (https://cran.r-project.org/) (searching R download should find this)

* Install RStudio (free version) from: (https://www.rstudio.com/products/rstudio/download/).

RStudio is an Integrated Development Environment (IDE) for R. IDEs add many useful features to your programming experience, panels showing history, help, plots, etc.  


# Work with R  
* Create a folder on your computer to save all the code and output files    
* Open Rstudio, click File - New project - Existing directory, then navigate to the folder you create in the last step, and click "Create" (You can also use the function setwd() to set the working directory, but I prefer creating a project since it is easier if you change the directory of saving the files in the future)   

# Labs        
* Lab 1: [R guide](R_Reference_Guide_for_IDM.html)   
* Lab 2: [Solving differential equations in R](Solving_Differential_Equations_in_R.html)    
* Lab 3: [SIR model with desolve](SIR_model.html). Can you adapt it to an SEIR model?   
* Lab 4: [SIR model with odin](http://epirecip.es/epicookbook/chapters/sir/r_odin). Can you adapt it to an SEIR model?  
* Lab 5: [SIR model calibration](Calibration_LS.html)
* Lab 6: [SIR model with interventions](Modeling_intervention.html)
* Lab 7: [Age-structured model](Age_structured_model.html)




# Optional    
* [Discrete time stochastic SIR model with odin](http://epirecip.es/epicookbook/chapters/sir-stochastic-discretestate-discretetime/r_odin)
* [Continuous time stochastic SIR model](http://epirecip.es/epicookbook/chapters/sir-stochastic-discretestate-continuoustime/r)  
* [Metapopulation model with odin](http://epirecip.es/epicookbook/chapters/lloydjansen2004/r_odin)   
* [Network model](http://epirecip.es/epicookbook/chapters/sircn/r) 

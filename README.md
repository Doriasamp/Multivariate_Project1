# MA369Project1
Project1 for Cluster 1 Group in Multivariate Statistical Methods

## Instructions for cloning this repo on RStudio 
- From your RStudio IDE, create a new project, then select Version Control
- Select Git to clone a project from a Git repo
- Copy this URL https://github.com/Doriasamp/Multivariate_Project1.git and paste it into the Repository URL
- You can rename the project if you like; this has only effect on your local env, not on the repo
- Click on Create Project

## What is inside the project
After the cloning process, you should be able to navigate the project files in the bottom right pane of your R IDE  
You may need to install the dependencies to run the scripts
- Just ignore gitignore
- Data source files (csv, txt, sas)
- main.R is the R script used to test functions before putting them into markdown
- report.Rmd is the actual markdown for the project

## How to collaborate in this project
First thing first, we are going to use GIT; you can use the terminal embedded into your RStudio IDE to send GIT commands in the command line if you feel confident doing that, or better, we use the graphical interface in R Studio.

### Pull the project
**IMPORTANT**  
Every time you open your RStudio project, you have to ensure the latest version of the project. To do that, you have to PULL the project from the repo.
On the top left pane of your RStudio, select the Git tab, then click on Pull. If your local version is up to date with the GitHub repo,  you will receive an "Already up to date" message; otherwise, it will synch your local project with the repo.  
Repeat this step every time you open the project from your RStudio to make modifications. After that, you can start working on the project.

### Commit your changes
You worked on the project and made some changes; now, you need to commit those changes.  
You can see the changes that are affecting the files in the Git tab. Select the file checkmark, then click the Commit tab. In the commit text field, please write a brief but descriptive message of your changes (i.e., "created boxplots for all variables).  
At the bottom of the text field, click on Commit.  
Once it is done, close that window.  

### Push your changes into the repo
Committing changes tells Git that your changes are saved and ready to be synched with the repo, but they are still not.  
You need to Push the changes, and you can do that again from the Git tab.  
Once you do that, the repo is now synched with all the changes you have committed before, and all other team members can see and work with the latest version of the project.



## Are There Ideological Asymmetries in Intergroup Bias? A Minimal Groups Approach

## Project description
The divide between political liberals and conservatives is rapidly growing. Several influential theories contend that this divide hinges on orientations towards social groups, such that conservatives (versus liberals) show a greater tendency to favor their “ingroups” and discriminate against “outgroups”. However, other theories contend that liberals and conservatives do not differ in their degree of intergroup bias. Both perspectives have received empirical support, and the debate has reached a standstill. We argue that this theoretical and empirical stalemate stems from inherent limitations of examining attitudes towards real-world social groups—a strategy used by both sides of the debate. Drawing on social identity theory, we conducted a series of four studies (Total N = 4064) using “minimal groups” (i.e., experimentally constructed groups) to determine whether and why ideological differences in intergroup bias may exist.

The project was accepted as a Stage 1 registered report at Nature Human Behaviour. This repository contains the analysis code for all analyses conducted as part of the project. The ReadMe describes the logic of the analysis code.

## File naming conventions
All analysis scripts are R Markdown and html files prefixed with the name of the dataset (NHB1 for Studies 1a and 1b, NHB2 for Study 2, NHB3 for Study 3). The prefix is followed by an indicator of the type of analysis that is conducted in the script:

* confirmatory: File contains preregistered confirmatory analyses
* exploratory: File contains exploratory analyses. If followed by '\_noprereg\_', exploratory analyses were not mentioned in the preregistration, otherwise they are preregistered exploratory analyses.
* reliability: File contains scale reliability analyses
* preprocessing: File contains data preprocessing steps
* descriptive: File contains descriptive analyses (demographics, scale descriptives)
* plot: File generates a plot
* summary: File summarizes results from other scripts

Where necessary for distinguishing multiple analyses, the script ends in a suffix that indicates the goal of the analysis. For example, the file 'nhb1\_exploratory\_traits-as-DV.Rmd' contains preregistered exploratory analyses that were conducted for Study 1a and 1b with trait scores as the dependent variable (due to low internal consistency of the combined measure for intergroup bias).

Custom functions that are called in scripts are defined in regular R scripts prefixed with 'helper_'.

HTML files contain the knitted output from R Markdown files. As a general rule, all code is made visible in the HTML file, i.e., all output is created by the code displayed above.

## General remarks on reproducibility

All scripts assume the following: 

* The working directory is set to the source file location.
* The data are stored at the highest level in a folder called 'data'
* There is a folder in the working directory called 'model-fits' (this is where brms model fit files are saved)

Data preprocessing scripts conduct preprocessing steps on the raw data. We publicly share preprocessed, but not raw data to protect the anonymity of our participants. This means results of data preprocessing cannot be reproduced without contacting the author team. However, the script provides a thorough documentation of the preprocessing steps. All confirmatory and exploratory analyses can be reproduced using the preprocessed data.

Bayesian analyses rely on Hamiltonian Monte Carlo sampling. We set a seed to make the random process reproducible on our machine, but since compiling is idiosyncratic on each machine, the seed will not guarantee reproducibility on other machines. This means that all Bayesian analyses are only reproducible with Monte Carlo error, i.e., Bayes factors and posterior estimates may deviate slightly from reported results if analyses are re-executed on a different machine. To make all analyses that depend on fitted model objects reproducible and allow others to investigate our posterior samples, we share the fitted model objects.

## Folder structure

The analyses assume the following folder structure:

:file_folder: data <br>
:file_folder: analyses<br>
---|:file_folder: NHB1<br>
---|:file_folder: NHB2<br>
---|:file_folder: NHB3<br>
---|:file_folder: Meta<br>

## Steps to reproduce analyses

### Study 1a and 1b

1. Open folder :file_folder: NHB1
2. Run preprocessing script. This creates preprocessed data saved in the data folder.
3. Run script 'nhb1\_confirmatory\_platform-decision.Rmd'. This reproduces the results shared with the editor that were used to make the decision to run the rest of the studies on the Prolific platform.
4. Run script 'nhb1\_confirmatory.Rmd'. This produces the main confirmatory hypothesis testing results that were included in the design table of the Stage 1 registered report.
5. Run reliability analysis script. This computes internal consistency of all scales and combined measures.
6. Run exploratory analysis scripts with suffix '...-as-DV'. These reproduce results from step 4 using ingroup-vs-outgroup identification, points, and traits as DV. Analyses were conducted because internal consistency of composite bias measure was inadequate.
7. Run exploratory analysis script with suffix 'favoritism-vs-derogation'. This reproduces exploratory results regarding whether bias is driven by ingroup favoritism or outgroup derogation. Due to the inadequate internal consistency of the composite bias measure, analyses were not only conducted using the composite bias measure, but also the individual bias measures (identification, Tajfel matrix points, traits). Due to the repeated-measures design (ingroup and outgroup scores for each participant) and the large number of participants, analyses take a long time to run (calculate with 24 hours for a regular PC). Decrease number of iterations per chain to speed things up or spread chains across multiple cores.
8. Run exploratory analysis script with suffix 'extremity'. This reproduces exploratory results for the influence of ideological extremity on intergroup bias. Due to the inadequate internal consistency of the composite bias measure, analyses were not only conducted using the composite bias measure, but also the individual bias measures (identification, Tajfel matrix points, traits).
9. Run exploratory analysis script with suffix 'interaction-ideology-extremity'. This reproduces exploratory results regarding the interaction effect of ideology and ideological extremity on intergroup bias. Due to the inadequate internal consistency of the composite bias measure, analyses were not only conducted using the composite bias measure, but also the individual bias measures (identification, Tajfel matrix points, traits).
10. Run script 'nhb1_plot_asymmetry.Rmd' to generate the scatterplot depicting the relation between ideology and bias in both platforms.

### Study 2
1. Open folder :file_folder: NHB2
2. Run preprocessing script. This creates preprocessed data saved in the data folder.
3. Run script 'nhb2\_confirmatory.Rmd'. This produces the main confirmatory hypothesis testing results that were included in the design table of the Stage 1 registered report.
4. Run reliability analysis script. This computes the internal consistency of all scales and combined measures.
5. Run exploratory analysis script with suffix 'extremity'. This reproduces exploratory results for the influence of ideological extremity on intergroup bias.
6. Run exploratory analysis scripts with suffix '...-as-DV'. These reproduce results from step 3 using ingroup-vs-outgroup identification, points, and traits as DV. Analyses were conducted because internal consistency of composite bias measure was inadequate.
7. Run script 'nhb2_plot_asymmetry.Rmd' to generate the scatterplot depicting the relation between ideology and bias in both platforms.

### Study 3
1. Open folder :file_folder: NHB3
2. Run preprocessing script. This creates preprocessed data saved in the data folder.
3. Run script 'nhb3\_confirmatory.Rmd'. This produces the main confirmatory hypothesis testing results that were included in the design table of the Stage 1 registered report.
4. Run reliability analysis script. This computes the internal consistency of all scales and combined measures.
5. Run exploratory analysis script with suffix 'extremity'. This reproduces exploratory results for the influence of ideological extremity on intergroup bias.
6. Run exploratory analysis scripts with suffix '...-as-DV'. These reproduce results from step 3 using ingroup-vs-outgroup identification, points, and traits as DV. Analyses were conducted because internal consistency of composite bias measure was inadequate.
7. Run script 'nhb3_plot_asymmetry.Rmd' to generate the scatterplot depicting the relation between ideology and bias in both platforms.

### Analyses across all studies
1. Open folder :file_folder: Meta
2. Run preprocessing script. This creates the dataset that serves as an input for the internal mini-meta analysis.
3. Run script 'meta_descriptives.Rmd'. This creates descriptive statistics for demographic information (e.g., age, gender, education) as well as core variables used in confirmatory hypothesis testing (e.g., composite bias). 
4. Run script 'meta_confirmatory.Rmd'. This reproduces the results of the mini-meta analysis as well as the multilevel analysis across all studies and conditions. Note that reproducing the Bayesian multilevel analysis can take a long time (~ 8 hours on a regular PC). To speed things up, decrease number of iterations per chain or spread chains across multiple cores.
5. Run script 'meta_exploratory_self-reported-vs-issue-based-ideology.Rmd'. This reproduces the average effect size calculations across different definitions of the independent variable (self-reported, issue-based ideology) and bias (combined score, Tajfel matrix points, group identification ratings, group trait evaluation ratings).
6. Run script 'meta_plot_minimeta.Rmd' to generate the forest plot depicting the relation between ideology and bias across studies and conditions.
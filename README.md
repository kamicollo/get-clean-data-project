#Dataset of human activity recorded with smartphones

This repository aims to clean and tidy the data collected in a research performed by [Jorge L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio, and Luca Oneto](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones), which built a a database from the recordings of 30 subjects performing activities of daily living (ADL) while carrying a waist-mounted smartphone with embedded inertial sensors. Refer to their webpage for further details about the study and the measurements performed.

This repository includes four files:

 - [run_analysis.R](run_analysis.R). This file, when run, downloads the original dataset, transforms it and outputs two files, described below. See below for details.
 - [measurements-by-activity-subject.txt](measurements-by-activity-subject.txt). This file includes a tidy dataset of the value for all subjects, all activities, but limited to measurements on the mean and standard deviation for each signal. Refer to [Codebook](Codebook.md) for details.
 - [average-measurements-by-activity-subject.txt](average-measurements-by-activity-subject.txt). This file includes a tidy dataset of the average value of each measurement for all subjects, all activities of the above file. Refer to [Codebook](Codebook.md) for details.
 - [Codebook](Codebook.md) describing the output files

##Definition of measurements included in the datasets

As mentioned above, these tidy datasets only include a subset of measurements taken in the original study. In particular, these include only the means and the standard deviations of the original sygnals captured. Other measures of original sygnals () as well as further derivative measurements are not included. If needed, the [run_analysis.R](run_analysis.R) could be adjusted (code lines 46-49) to capture other measurements as well.

##Analysis file

[run_analysis.R](run_analysis.R) file downloads the original dataset, saves it to a temporary location and thus leaves no traces after itself. As the original dataset includes several descriptive files, for the purpose of inspection, one can download it separately from [authors' website](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones) or [CloudFront](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip). 

Alternatively, the [run_analysis.R](run_analysis.R) can be easily adjusted to save the download file to a permanent location. This is done by passing download_data() a second parameter with a desired location (code line 28).

Similarly, output destinations of the two output can be controlled via variables set in code lines 24-25.

The file is extensively commented, we refer to source code for further descriptions of its inner workings.

##Reading output files

To read output files into R use command `read.table('selected-file.txt', header=TRUE, stringsAsFactors = TRUE))`.

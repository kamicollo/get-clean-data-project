#CodeBook

##Raw data

The output files provided are based on a [human activity dataset collected using smartphones](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)). See [README](README,md) for details. The output files essentially combine and subset the data included in the original dataset.

##Data included

1. The original dataset includes a training and a test dataset (subset by participating subject). The output files are based on a merged dataset.

2. The original dataset includes 561 features, which are various measurements (mean, standard deviation, kurtosis, skenewess, etc) of sygnals captured from the smartphones (using gyrometer, accelerator), as well as further derivative measurements. See the original dataset, `features_info.txt` file for details. The output files are limited to mean and standard deviation measurements of sygnals (66 features in total).

##Data transformations

1. While the original dataset is provided in a long format, the output files were "normalized", i.e. features are listed in one column and their measurements - in another.

1. All feature and activity naming information was merged into the main dataset and thus now includes actual string descriptions, not the number identifiers as in the original dataset.

2. All activity names were lowercased.

No further data transformations were performed.

##Data description

1. `Activity` field is a factor comprising 6 levels of activities performed by subjects when the measurements were captured. The activity definitions can be found in the original dataset.

2. `Subject` field denotes the identifier of the subject performing the activity. The dataset includes a total of 30 subjects; all of them performed all activities. 

3. `Measurement` field denotes the measurement captured. As explained above, only 66 measurements (converted to factors) are included in the output files. The measuremement definitions and derivations can be found in the `features_info.txt` file of the original dataset.

4. `Value` field includes the value of the measurements.
    - In `average-measurements-by-activity-subject.txt` file, the value represents the measurement value averaged for each subject and each activity.
    - In `measurements-by-activity-subject.txt` file, the value represents the measurement value as captured in the original study.
    
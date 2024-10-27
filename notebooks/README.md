# Data preperation and model training notebooks

The following jupyter notebooks are use for model training and data preperation
We did our best to document our approach and different decisions we took directly in the notebooks

## `notebooks/trajectory_feature_extraction_ias_norm_virt_rate.ipynb`
Trajectores are cleaned to keep in-the-air part and only the relevant features to compute airspeed and normalised vertical rate. First created a copy of the 2022 parquet files with only necessary data (smaller sizes).

## `notebooks/trajectory_feature_extraction_general_aggregrations_vertical_rate_density_altitude.ipynb`


## `ias_norm_virt_rate_feature_design.ipynb`
Experiments on random Traffic trajectory samples to build the basis of airspeed and normalised vertical rate feature

## `ias_norm_virt_feature.ipynb`
extracting airspeed and normalized vertical rate from all trajectories


## `notebooks/training.ipynb`
model training and inference
```
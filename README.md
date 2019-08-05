# Jupyter Notebook with Miniconda
### Its only in Anaconda full installation, with miniconda use conda install jupyter

# master-thesis
### Code used for analyze soil moisture properties 

## Step 1 (download_radolan): Download radolan precipitation data from dwd ftp server
  ### Modules needed: pyftpdlib, os, tarfile 
  ### To get it work change working dir folders in script
  ### How it works: Go to ftp folder of DWD precipitation data; Check if file is already on drive and if file is not corrupted skip downloading otherwise download the file

## Step 2 (unzip_radolan_tar):Unpack radolan data tar.gz -> .bin
  ### Modules needed: tarfile, os
  ### How it works: Try to untar all files in same folder or try to untar only specific files out of a tar file
  ###To-Do:
            - some archives have bin.gz they have to be also untared/ziped/gized
            
## Step 3 (wradlib): make readable raster data from .bin data
  ### Modules needed: wradlib, numpy
  ### How it works: Load .bin data from Step 2; georeference with radolan projection and german grid (900 x 900) and reproject it to WGS 84 Mercator?? (EPSG 3857); save it as Gtif

### Notes on Step 2 and 3: Some problems with doubled tared filez, in total script only solves 2013-2019 with some extra work outside the scripts. For 2006-2013 untar problem accures

## Step 4 (upload_gee_2): Upload data from local drive -> GCS Bucket -> GEE
  ### Modules needed: Mainly work with command line 
  ### How it works: See https://www.tucson.ars.ag.gov/notebooks/uploading_data_2_gee.html#

# Products
## Soil 
### WMS
#### BÜK 200 / https://services.bgr.de/wms/boden/buek200/? / https://www.bgr.bund.de/DE/Themen/Boden/Informationsgrundlagen/Bodenkundliche_Karten_Datenbanken/BUEK200/buek200_node.html
### earth engine
#### NASA-USDA SMAP Global Soil Moisture Data / 2015-04-01 - Present / sm, sum, sp / 27-28 km / https://developers.google.com/earth-engine/datasets/catalog/NASA_USDA_HSL_SMAP_soil_moisture
#### GLDAS-2.1: Global Land Data Assimilation System / 2000 - Present / ground based  /sm 10-200cm / air temp 27-28 km / https://developers.google.com/earth-engine/datasets/catalog/NASA_GLDAS_V021_NOAH_G025_T3H
#### Copernicus CORINE Land Cover / 1986 - 2012
## Landcover
### earth engine
#### Global PALSAR-2/PALSAR Forest/Non-Forest Map / 2007 - 2018 / 25 m / f, nf, water / https://developers.google.com/earth-engine/datasets/catalog/JAXA_ALOS_PALSAR_YEARLY_FNF
#### MCD12Q1.006 MODIS Land Cover Type Yearly Global / 2001 - 2017 / 500m / Landcover / https://developers.google.com/earth-engine/datasets/catalog/MODIS_051_MCD12Q1
#### MCD12Q1.051 Land Cover Type Yearly Global / 2000 - present / 500m / Landcover / https://developers.google.com/earth-engine/datasets/catalog/MODIS_051_MCD12Q1
#### GFSAD1000: Cropland Extent 1km Crop Dominance, Global Food-Support Analysis Data / 2000 - present / 1km / Cropland - global irrigated and rainfed cropland area map / https://developers.google.com/earth-engine/datasets/catalog/USGS_GFSAD1000_V0

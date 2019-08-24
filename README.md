# Jupyter Notebook with Miniconda
### Its only in Anaconda full installation, with miniconda use conda install jupyter

# master-thesis
 Find mysterious soil property corresponding to soil-moisture behaviours 
 Properties affecting soil moisture:
 1. Soil type
 2. Organic content
 3. Precipitation (check: Radolan 1000m)
 4. Vegetation (check: CLC 100m, Bare-soil condition through classification with indizes 10m)
 5. Altitude (check strm 30 30m)
 6. Sun radiation
 7. Cloudcover (check: sentinel 1, 10m)
 8. Soil temperature
 9. Air temperature
 10. Evaporation / Evapotranspiration
 11. Wind relation
 12. ?
 Needed data: Precipitation, Bare-Soil, Soil-Moisture, Evapotranspiration/Evaporation, 


## Precipitation 
### Step 1 (download_radolan): Download radolan precipitation data from dwd ftp server
   Modules needed: pyftpdlib, os, tarfile   
   To get it work change working dir folders in script  
   How it works: Go to ftp folder of DWD precipitation data; Check if file is already on drive and if file is not corrupted skip downloading otherwise download the file  
   To-Do: To do Step2 download all files inside one folder  

### Step 2 (unzip_radolan_tar):Unpack radolan data tar.gz -> .bin
   Modules needed: tarfile, os  
   How it works: Use second part of the script. All files must be in the same folder, better when no other files except the      .tar.gz files are inside the folder. Extract all files inside the tar archive with the corresponding time     variable inside the same folder  
          
### Step 3 (wradlib_warps_translate): make readable raster data from .bin data
   Modules needed: wradlib, numpy, osgeo  
   How it works: Use part of the script where all files located in single folder and creating osr objects is inside the for loop... Load .bin data from Step 2;   georeference with radolan projection and german grid (900 x 900) and reproject it to GK3 and save it as Gtif. Doesent work in Gee it is deprojected i don't know why? But the radolan stereo projection works for now so take this      

#### Notes on Step 2 and 3: Some problems with doubled tared filez, in total script only solves 2009-2019 with some extra work outside the scripts. For 2006-2013 untar problem accures

### Step 4 (upload_gee_2): Upload data from local drive -> GCS Bucket -> GEE
   Modules needed: Mainly work with command line  
   How it works: See https://www.tucson.ars.ag.gov/notebooks/uploading_data_2_gee.html#    
   Save transferbuckettogee.sh in folder with .tif files to get date property set and run it with "source ransferbuckettogee.sh"  
   Problem: you have to run earthengine create collection bla/bla/bla and remove it in script because of a / at the end of $imcol the command isn't valid but is necessary for script solution: new $variable  
   In case you have to delete collections inside GEE look at https://developers.google.com/earth-engine/command_line  

### Step 5 Get Soil Map  
   Source:  http://bodenviewer.hessen.de/mapapps/resources/apps/bodenviewer/index.html?lang=de  
   How it works: Make a screenshot with no background information. Go to arcmap or qgis and georeference the image. save it as tiff. Than use cluster_images.py to classify image with kmeans   
   
## AOI
   Hessisches Ried Das Hessische Ried umfasst die Hessische Rheinebene und den hessischen Teil der Nördlichen Oberrheinniederung (naturräumliche Einheiten 225 und 222) https://de.wikipedia.org/wiki/Hessisches_Ried  
   
## Bare-Soil detection
   Remote Sensing (GEE): 
   Soil Indizes: https://www.indexdatabase.de/db/ia.php?application_id=2
   Ground Trouth campain: mapping at the end of the crop season

## Soil-Moisture estimation
   Ground Trouth campain: DIY moisture sticks 
   Remote Sensing (GEE): 

## Soil-Map Hessisches Ried  
   Go-To http://bodenviewer.hessen.de/mapapps/resources/apps/bodenviewer/index.html?lang=de
   Make screenshots for AOI ; maybe later script this part  
   Autosticht for stich process https://www.heise.de/download/product/autostitch-27347/download  
   Python Script cluster_images nutzen um durch kmeans die Karte wiederherstellen
   
## Landcover concept
 Soil moisture observations over crop- and bare soil maybe valid. Forest, build-up/urban or water seems to be invalid   because of high scattering effects and poor quality SAR data.   

 First Try: DE GM(500m) / Corine Landcover 100m / radolan 1km/  Boden Übersichtskarte BGR 2km /   

# Products
open data deutschland - http://de.digital-geography.com/open-data-deutschland-freie-geodaten-von-bund-und-landern/ 
## Boundarys
### earth engine
 international countrie borders / table-featurecollection / https://developers.google.com/earth-engine/datasets/catalog/USDOS_LSIB_2013
## Soil 
### WMS
 BÜK 200 / https://services.bgr.de/wms/boden/buek200/? / https://www.bgr.bund.de/DE/Themen/Boden/Informationsgrundlagen/Bodenkundliche_Karten_Datenbanken/BUEK200/buek200_node.html
### earth engine
 NASA-USDA SMAP Global Soil Moisture Data / 2015-04-01 - Present / sm, sum, sp / 27-28 km / https://developers.google.com/earth-engine/datasets/catalog/NASA_USDA_HSL_SMAP_soil_moisture
 GLDAS-2.1: Global Land Data Assimilation System / 2000 - Present / ground based  /sm 10-200cm / air temp 27-28 km / https://developers.google.com/earth-engine/datasets/catalog/NASA_GLDAS_V021_NOAH_G025_T3H
 Copernicus CORINE Land Cover / 1986 - 2012
## Landcover
 Corine Land Cover / 10-100m https://land.copernicus.eu/pan-european/corine-land-cover/view WMS: http://sg.geodatenzentrum.de/wms_clc10_2012
### earth engine
 Copernicus CORINE Land Cover / 86 - 2012 / 100m / https://developers.google.com/earth-engine/datasets/catalog/COPERNICUS_CORINE_V18_5_1_100m
 Global PALSAR-2/PALSAR Forest/Non-Forest Map / 2007 - 2018 / 25 m / f, nf, water / https://developers.google.com/earth-engine/datasets/catalog/JAXA_ALOS_PALSAR_YEARLY_FNF
 MCD12Q1.006 MODIS Land Cover Type Yearly Global / 2001 - 2017 / 500m / Landcover / https://developers.google.com/earth-engine/datasets/catalog/MODIS_051_MCD12Q1
 MCD12Q1.051 Land Cover Type Yearly Global / 2000 - present / 500m / Landcover / https://developers.google.com/earth-engine/datasets/catalog/MODIS_051_MCD12Q1
 GFSAD1000: Cropland Extent 1km Crop Dominance, Global Food-Support Analysis Data / 2000 - present / 1km / Cropland - global irrigated and rainfed cropland area map / https://developers.google.com/earth-engine/datasets/catalog/USGS_GFSAD1000_V0

Resources
Open Data - Freie Daten und Dienste des BKG http://www.geodatenzentrum.de/geodaten/gdz_rahmen.gdz_div?gdz_spr=deu&gdz_akt_zeile=5&gdz_anz_zeile=1&gdz_unt_zeile=0&gdz_user_id=0
Umweltatlas Hessen: http://atlas.umwelt.hessen.de/atlas/haupt.htm


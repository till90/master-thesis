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
  
   

# ******************** Bash script ********************************************#
#!/bin/bash
# Define static variables
# Transfer files into existing bucket or make new bucket with gsutil mb gs://my_bucket
gsutil -m cp *.tif gs://radolan/r_2009-2019_gk3/ 
gcBucket="radolan/r_2009-2019_gk3/"
imgCol="users/tillmueller1990/radolan/r_2009-2019_gk3/"
earthengine create collection $imgCol
# Create asset in GEE
strProv="(string)provider=DWD"
# Get file names to extract date and call ingestion command for each file to be added into an asset as image collection
# Example of filenames used here are from a monthly timeseries: rainfall_US_20140101.tif
for file in *.tif; do
    var=$file                       # Get the file name
    yr=${var:0:2}                  # Extract year from the filename, to get this index use the filename and check the index for the year within the filename.  0-based-index
    mon=${var:2:2}                 # Same for extracting month
    day=${var:4:2}
    vdate="20"$yr"-"$mon"-"$day"T23:50:00"  # Concatenate strings to get a valid date format to use in the data ingestion co:mmand
    # Remove filename extension ".tif"
    name=$(echo $file | cut -f 1 -d '.')
    asset=$imgCol$name
    # For testing before running, use the following echo statament to print out the final command
    #echo earthengine upload image --asset_id="${asset}" --pyramiding_policy=sample --time_start="${vdate}" --property="\x22${strProv}\x22" --nodata_value=-9999 gs://$gcBucket$file
    # Call the ingestion command with the corresponding parameters to populate properties at each image ingested
    earthengine upload image --asset_id="${asset}" --pyramiding_policy=sample --time_start="${vdate}" --property="${strProv}" --nodata_value=-9999 gs://$gcBucket$file
done


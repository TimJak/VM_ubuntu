#!/bin/bash
echo "JakVeenenebos, Tim Jak & Koen Veenenbos"
echo "12 January 2016"
echo "Calculate LandSat NDVI"

cd ../userdata
fn=$(ls *.tif)

echo "The input file: $fn"
outfn="ndvi.tif"
outfn2="ndvi_resampled"
outfn3="ndvi_reprojected"

echo "The output file: $outfn"
echo "calculate ndvi"
gdal_calc.py -A input.tif --A_band=4 -B $fn --B_band=3  --outfile=$outfn  --calc="(A.astype(float)-B)/(A.astype(float)+B)" --type='Float32'

echo "Change the resolution to 60x60 meters."
gdalwarp -tr 60 60 $outfn $outfn2

echo "Reproject the file to EPSG:4326."
gdalwarp -t_srs EPSG:4326 $outfn2 $outfn3
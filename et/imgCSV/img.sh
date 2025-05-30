#! /bin/bash

rm -rf criteria.sh ;
rm -rf csvcut.sh ;
rm -rf mmd.sh ;
rm -rf prefixes.txt ;
rm -rf rename_csv.sh ;
rm -rf rename_png copy.sh ;
rm -rf rename_png.sh ;
rm -rf src/ ;
rm -rf turtle.sh ;
rm -rf ttl/ ;
rm -rf *.csv ;

cp ../scripts/prefixes.txt .
cp ../scripts/csvcut.sh .
cp ../scripts/mmd.sh .
cp ../scripts/criteria.sh .
cp ../scripts/turtle.sh .
cp ../scripts/rename_png.sh .
cp ../scripts/rename_csv.sh .
cp -R ../scripts/src/ src/

python ../airscraper/airscraper/airscraper/airscraper.py https://airtable.com/shrRHLNBY9aauxjN1 > img_name.csv ;
python ../airscraper/airscraper/airscraper/airscraper.py https://airtable.com/shrYEc5xsyqDySvXi > img_rights.csv ;
python ../airscraper/airscraper/airscraper/airscraper.py https://airtable.com/shrTSwrtsmLVpQqrv > img_desc.csv ;
python ../airscraper/airscraper/airscraper/airscraper.py https://airtable.com/shrTGH1Zgl9ntFRPg > img_about.csv ;
python ../airscraper/airscraper/airscraper/airscraper.py https://airtable.com/shrumNnAkITdwEqb8 > img_item.csv ;
python ../airscraper/airscraper/airscraper/airscraper.py https://airtable.com/shrngxPTue2ReArgs > img_existence.csv ;


echo "finished download"
./csvcut.sh
cd ttl/
./turtle.sh
echo "converted to RDF"
./criteria.sh
echo "converted to Mermaid"
cd mmd/
./mmd.sh
echo "converted to PNG"
cd png/
./rename_png.sh
echo "done"

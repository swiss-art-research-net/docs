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

python ../airscraper/airscraper/airscraper/airscraper.py https://airtable.com/shrlvU6EIH2wcRHAr > carrier_name.csv ;
python ../airscraper/airscraper/airscraper/airscraper.py https://airtable.com/shrP3qyjHyldwCinX > carrier_parthood.csv ;
python ../airscraper/airscraper/airscraper/airscraper.py https://airtable.com/shrZBQw6eo5HjqVOB > carrier_description.csv ;
python ../airscraper/airscraper/airscraper/airscraper.py https://airtable.com/shrBPn71lh3Mwk14E > carrier_existence.csv ;
python ../airscraper/airscraper/airscraper/airscraper.py https://airtable.com/shrAqyHN96UjuTqaF > carrier_substance.csv ;
python ../airscraper/airscraper/airscraper/airscraper.py https://airtable.com/shrxh9ZO3yer4J8Pv > carrier_events.csv ;
python ../airscraper/airscraper/airscraper/airscraper.py https://airtable.com/shrHeEMUeE2ifLBXk > carrier_relations.csv ;
python ../airscraper/airscraper/airscraper/airscraper.py https://airtable.com/shrF3T5yRwKd9cRZB > carrier_location.csv ;
python ../airscraper/airscraper/airscraper/airscraper.py https://airtable.com/shrWznqk5ZUffH2xv > carrier_rights.csv ;

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

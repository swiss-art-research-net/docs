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

python ../airscraper/airscraper/airscraper/airscraper.py https://airtable.com/shrNXdw7WZJf77xO6 > archival_names.csv ;
python ../airscraper/airscraper/airscraper/airscraper.py https://airtable.com/shrBZTbMD2dJJ7Chi > archival_rights.csv ;
python ../airscraper/airscraper/airscraper/airscraper.py https://airtable.com/shrd22DtCX0GG34Jg > archival_location.csv ;
python ../airscraper/airscraper/airscraper/airscraper.py https://airtable.com/shrlSnotc4ugNYIjj > archival_desc.csv ;
python ../airscraper/airscraper/airscraper/airscraper.py https://airtable.com/shrA5yMyUjWkgnajD > archival_docs.csv ;
python ../airscraper/airscraper/airscraper/airscraper.py https://airtable.com/shrw2FJaaT8jrK8M1 > archival_parthood.csv ;
python ../airscraper/airscraper/airscraper/airscraper.py https://airtable.com/shrbkP7XeL2ZkC1Hb > archival_existence.csv ;
python ../airscraper/airscraper/airscraper/airscraper.py https://airtable.com/shr5CqSEquR1GH73U > archival_substance.csv ;
python ../airscraper/airscraper/airscraper/airscraper.py https://airtable.com/shrH0zA2yRwub0LEd > archival_aboutness.csv ;
python ../airscraper/airscraper/airscraper/airscraper.py https://airtable.com/shr1POYwgIiUtUm2a > archival_events.csv ;
python ../airscraper/airscraper/airscraper/airscraper.py https://airtable.com/shrbplxdEnio2noxQ > archival_relation.csv


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

#! /bin/bash

# Generates the tarball and html documentation, upload it to gna.org
# This file is currently used only by Matthieu MOY, and is provided
# here only as an example. Copy it and modify it if you wish to use it.

export PATH=${HOME}/bin/local/verimag:${PATH}

cd `dirname $0`/..
mkdir -p tmp

echo "Executing $0 on $(date)."

make tarball
mkdir -p www/download/
cp dvc-snapshot.tar.gz www/download/
make -C texinfo dvc.html
mkdir -p www/docs/
cp texinfo/dvc.html www/docs/dvc-snapshot.html

# upload source and non-source at the same time
rsync -av www/ moy@download.gna.org:/upload/dvc/

echo "Finished $0 on $(date)"

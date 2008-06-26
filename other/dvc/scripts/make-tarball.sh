#! /bin/sh

tempdir=/tmp/dvc-tarball.$$
workdir=$(pwd)
tarballname=$1

if [[ $tarballname = "" ]]; then
    tarballname="$(basename $workdir).tar.gz"
fi

dirname=$(echo "$tarballname" | sed -e 's/\.tar\.gz$//' -e 's/\.tgz$//')

rm -fr $tempdir
mkdir $tempdir

(cd lisp; make dvc-version.el)
(cd texinfo; make dvc-version.texinfo)

bzr branch . "$tempdir/$dirname/"
for file in lisp/dvc-version.el texinfo/dvc-version.texinfo
do
    cp "$file" "$tempdir/$dirname/$file"
done

cd $tempdir ; tar -cvzf "${workdir}/${tarballname}" "$dirname"
rm -fr $tempdir

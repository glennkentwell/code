#!/bin/bash
github_repo=github
wd=$PWD
rand=$RANDOM
git clone . /tmp/dissent.$rand
cd /tmp/dissent.$rand

function cleanup {
  echo $1
  cd $wd
}

qmake test.pro
if test $? -ne 0; then
  cleanup "Error qmake test.pro"
  exit 1
fi

make -j8
if test $? -ne 0; then
  cleanup "Error make"
  exit 1
fi

./test --gtest_catch_exceptions=0 --gtest_throw_on_failure
if test $? -ne 0; then
  cleanup "Error running test"
  exit 1
fi

builds="
application.pro
entry_tunnel.pro
exit_tunnel.pro
keygen.pro
"

for build in $builds; do
  qmake $build
  if test $? -ne 0; then
    cleanup "Error qmake $build"
    exit 1
  fi

  make
  if test $? -ne 0; then
    cleanup "Error make $build"
    exit 1
  fi
done

cd $wd
git push $github_repo master
if ! test -d $wd/docs/html; then
  cleanup "All done!"
  rm -rf /tmp/dissent.$rand
  exit 0
fi

cd /tmp/dissent.$rand
doxygen dissent.doxy >& /dev/null
rm -rf $wd/docs/html/*
cp -axf docs/html/* $wd/docs/html
cd $wd/docs/html
git add .
git commit -m "documentation update"
git push $github_repo gh-pages
cleanup

Buildpack (Heroku, CloudFoundry, Dokku, etc.) that just installs id3lib. Most
likely use with heroku-buildpack-multi to actually build a stack.

Build Steps
===========

Used to build id3lib 3.8.3 package that this buildpack uses (https://s3.amazonaws.com/buildpack-id3lib/id3lib-3.8.3.tgz):

Setup `vulcan` to build:
```
sudo gem install vulcan
vulcan create id3lib-3.8.3
```

Download and uncompress id3lib:
```
curl -O http://downloads.sourceforge.net/project/id3lib/id3lib/3.8.3/id3lib-3.8.3.tar.gz
tar xzvf id3lib-3.8.3.tar.gz
```

Download patch & apply to compile with GCC 4+:
```
curl -O http://connie.slackware.com/~alien/slackbuilds/id3lib/build/id3lib-3.8.3_gcc4.diff
cd id3lib-3.8.3
patch -p1 < ../id3lib-3.8.3_gcc4.diff
```

Finally, build it w/ vulcan:
```
vulcan build -v -s . -c "./configure --prefix=/tmp/id3lib-3.8.3 && make && make install" -p /tmp/id3lib-3.8.3 -o ../id3lib-3.8.3.tgz
```

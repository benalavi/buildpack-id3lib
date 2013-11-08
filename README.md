Heroku buildpack that just installs id3lib.

Usage
=====

You probably want to compose this with other buildpack(s) using
heroku-buildpack-multi (https://github.com/ddollar/heroku-buildpack-multi).

Add https://github.com/benalavi/buildpack-id3lib.git to your `.buildpacks`
(before anything that depends on id3lib).

Now your other buildpacks (say ruby) should be able to compile against id3lib.

Note that there is currently no way to pass environment variables between
buildpacks using the heroku-buildpack-multi buildpack. So you'll likely want to
actually use the one referenced in this pull request:
https://github.com/ddollar/heroku-buildpack-multi/pull/18 by setting your
buildpack to: https://github.com/mojodna/heroku-buildpack-multi.git#d27d886f

Testing
=======

`ruby test/id3lib_test.rb`

Or, if you don't have the necessary dependencies and would like to run a VM (via Vagrant) with them installed for you:

```
vagrant up
vagrant ssh
cd /vagrant
ruby test/id3lib_test.rb
```

id3lib 3.8.3 package
--------------------

These are the steps used to build the id3lib 3.8.3 package that this buildpack
installs (https://s3.amazonaws.com/buildpack-id3lib/id3lib-3.8.3.tgz).

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

Download patch for GCC 4+ & apply:
```
curl -O http://connie.slackware.com/~alien/slackbuilds/id3lib/build/id3lib-3.8.3_gcc4.diff
cd id3lib-3.8.3
patch -p1 < ../id3lib-3.8.3_gcc4.diff
```

Finally, build it w/ vulcan:
```
vulcan build -v -s . -c "./configure --prefix=/tmp/id3lib-3.8.3 && make && make install" -p /tmp/id3lib-3.8.3 -o ../id3lib-3.8.3.tgz
```

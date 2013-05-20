Plone 4 buildout
================

[![Build Status](https://travis-ci.org/RedTurtle/deployments.buildout.plone.png?branch=master)](https://travis-ci.org/RedTurtle/deployments.buildout.plone)

Introduction
------------
This is the a very basic buildout template

I am feeling lucky!
-------------------
Run this:
```
./.imfeelinglucky.sh
```

For the impatients
------------------
Make a symlink to the file you want to use (e.g. `development.cfg`) and start the buildout:
```bash
$ ln -s profiles/development.cfg buildout.cfg
$ python2.7 bootstrap.py
$ ./bin/buildout
```

Before you start
----------------
Probably you may want to set up your system and configure some parameters!
Don't forget to read the full documentation.

### Requirements ###
You may want to install this to get this buildout working:
```bash
# python stuff
$ apt-get install python-dev python-virtualenv
# version control stuff
$ apt-get install git subversion
# other stuff
$ apt-get install libjpeg8-dev poppler-utils  wv libgeos-c1
```

### Plone version ###
In the file `config/base.cfg` you may can control the plone version by changing the
__extends__ and __find-links__ variables:
```cfg
extends = 
    http://dist.plone.org/release/4.3/versions.cfg
    ...

find-links =
    http://dist.plone.org/release/4.3
    ...
```

### Virtualenv ###
Using a virtualenv is a good idea:
```bash
# NOTE: --no-site-packages is the default behaviour of the newer virtualenv
#       you might remove this parameter if you get an error
$ virtualenv --no-site-packages -p /usr/bin/python2.7 .
$ . bin/activate
```

### Add additional eggs to Plone ###
Customize the __eggs__ and the __zcml__ variable in the **[plone]** section (a
good place is `config/base.cfg`), e.g:
```cfg
[plone]
eggs+=
    my.egg
zcml+=
    my.egg
```

### Add development eggs with mr.developer ###
Customize the **[sources]** section (a good place is `profiles/development.cfg`) adding
your checkouts, e.g:
```cfg
[sources]
collective.developermanual = git git://github.com/collective/collective.developermanual.git
```

The provided configuration files
--------------------------------
In the directory `./profiles` you will find configs that can be symlinked in the root of the buildout.

__You shouldn't use directly configuration files that are stored in `config` folder.__

Beneath is the list of available configurations:

### development.cfg ###
This is what the developer wants!
Gives you a standalone Plone instance (no ZEO).
As usual you can launch it with:
```bash
$ ./bin/instance fg
2013-03-22 13:58:39 INFO ZServer HTTP server started at Fri Mar 22 13:58:39 2013
Hostname: 0.0.0.0
Port: 8080
2013-03-22 13:58:44 INFO Zope Ready to handle requests
```
Adds to the buildout development scripts (`test`, `i18ndude`) and to plone some
products (`plone.reload` and `stxnext.pdb`).
Some other are suggested (commented) In the `profiles/development.cfg` file.
Ask for new stuff if you want (`sauna.reload`, `plone.app.debugtoolbar`, ...).

### production.cfg ###
This is what you want for a production system.

Using `production.cfg` you will install the services:
- zeoserver
- instance1
- debuginstance

the management scripts:
- bin/zeopack
- bin/repozo

the logrotate machinery:
- etc/logorate.conf
- bin/postrotate.sh

#### Log rotation ####
The logrotation is handled externally from Zope by choice. This allows at any time to use the system logrotate capabilities.
To enable/update the configuration created via buildout
you have to manualy copy or symlink the etc/logrotate.conf file to the proper location. See the `etc/logrotate.conf` file header (created after you succesfully run the production buildout).

#### munin ####
`production.cfg` will provide you a script to deploy (if needed)
symlinks for munin.zope.

#### ZopeHealthWatcher ####

Remember to customize the `custom.py` file:
```bash
vi eggs/ZopeHealthWatcher*.egg/Products/ZopeHealthWatcher/custom.py
```

Then use it like this:
```bash
bin/zope_health_watcher http://localhost:8080
```

Or visit http://localhost:8080/manage_zhw?the_secret_you_put_in_custom.py

Note
----
### Versions pinning ###
The buildout prints unpinned versions at the end of the build.
You may want to add them to some cfg file.

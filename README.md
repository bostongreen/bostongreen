Setup
-----

Install any ruby. RVM is optional, but highly recommended.  This app will use 1.9.2 and create a gemset.

    rvm install 1.9.2

Install the bundler gem

    gem install bundler
    
Get the code onto your local machine:

    git clone git@github.com:patricksrobertson/BostonHackDay.git
    cd BostonHackDay

Install the required gems

    bundle install

Start Sphinx search server

	rake ts:start

Run the tests

    rake

Contributing
------------

* Please create a fork of this repository and submit a pull request.
* Please use a feature/topic branch for your pull request.
* Please include tests on your request.

License
-------

Copyright 2011 Patrick Robertson and other contributors 

Licensed under GPL v3.  For full text of license, see 
http://www.gnu.org/licenses/gpl.txt" 

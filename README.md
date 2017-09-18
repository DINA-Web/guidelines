For more information about the DINA Project, please visit the [DINA wiki](http://www.dina-project.net/wiki/DINA_Technical_Committee).

Authors
-------

* DINA International consortium - Technical Committee
* DINA team at NRM

DINA Guidelines
==============================

-   [Web API Guidelines](DINA-Web-API-Guidelines.md)
-   [Release Guidelines](DINA-Web-Release-Guidelines.md)
-   [QA Guidelines](DINA-Web-QA-Guidelines.md)

## Guidelines in Blueprint format

The .apib is a markdown format that allows for various tooling.

A `Makefile` is available that can be used to render and validate guidelines written in API Blueprint format.

Usage:
	
	# validate, generate report and HTML versions
	make APIB=DINA-Web-API-Guidelines.apib
	
	# run tests
	make APIB=DINA-Web-API-Guidelines.apib test
	
	# clean up
	make down
	make clean

## Links

- https://help.apiary.io/api_101/choosing-format/

	
Status of the documents
-----------------------

* Cybersecurity: draft by TC
* API: outdated binding guidelines by TC
* Licensing: links to draft guidelines at https://dina-web.net/licensing.html
* QA: draft recommendation by TC
* Release: recommendation by TC
* UI: unofficial fork of http://blog.dina-web.net/guidelines/style.html

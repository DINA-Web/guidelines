For more information about the DINA Project, please visit the [DINA wiki](http://www.dina-project.net/wiki/DINA_Technical_Committee).

Authors
-------

DINA International consortium - Technical Committee

DINA Guidelines
==============================

-   [Web API Guidelines](DINA-Web-API-Guidelines.md)
-   [Release Guidelines](DINA-Web-Release-Guidelines.md)
-   [QA Guidelines](DINA-Web-QA-Guidelines.md)

## Guidelines in Blueprint format

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

- https://medium.com/@knightstickc/building-an-api-with-swagger-json-api-and-rails-part-2-8f9691e3de04#.8dggtu6bl

	

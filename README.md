For more information about the DINA Project, please visit the [DINA wiki](http://www.dina-project.net/wiki/DINA_Technical_Committee).

Authors
-------

* DINA International consortium - Technical Committee
* DINA team at NRM

DINA Guidelines
==============================

- [Web API Guidelines](DINA-Web-API-Guidelines.md) - outdated recommendation by TC
- [Development Guidelines](DINA-Web-Development-Guidelines.md) - draft recommendation by TC
- [Release Guidelines](DINA-Web-Release-Guidelines.md) - recommendation by TC
- [QA Guidelines](DINA-Web-QA-Guidelines.md) - draft recommendation by TC
- [Licensing Guidelines](DINA-Web-Licensing-Guidelines.md) - draft recommendation by TC
- [Visual style Guidelines](DINA-Web-UI-Guidelines.md) - draft recommendation by TC
- [Cybersecurity Guidelines](DINA-Cybersecurity-Guidelines.md) - draft recommendation by TC 

## Guidelines in Blueprint format

The `.apib` format is a markdown format that allows for various tooling. A `Makefile` is provided that for example can be used to render and validate guidelines written in API Blueprint format.

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



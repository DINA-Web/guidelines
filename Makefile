#!make

APIB = blueprint.apib
PWD = $(shell pwd)

all: init up docs report

init:
	curl -o /tmp/temp.apib \
		"https://raw.githubusercontent.com/gnewton/test/master/req2.md"

	# need to do this bec the dredd validator complains on .apib format with tabs
	cat /tmp/temp.apib | tr -d '\t' > $(APIB) && rm -f /tmp/temp.apib

up:
	docker network create mockery
	docker run -d --name mock --network mockery \
		-v $(PWD)/$(APIB):/usr/src/app/api.md -p 3000:3000 \
		ajnasz/api-mock

down:
	docker stop mock
	docker rm -vf mock
	docker network rm mockery

test:
	docker run -it --rm --network mockery \
		-v $(PWD):/tmp apiaryio/dredd \
		dredd /tmp/$(APIB) http://mock:3000

report:
	docker run -it --rm --network mockery \
		-v $(PWD):/tmp apiaryio/dredd \
		dredd /tmp/$(APIB) http://mock:3000 --dry-run > $(APIB).log

docs:
	docker run -ti --rm -v $(PWD):/docs humangeo/aglio \
		/usr/local/bin/aglio -i $(APIB) -o $(APIB).html

clean:
	rm -f $(APIB) $(APIB).html $(APIB).log

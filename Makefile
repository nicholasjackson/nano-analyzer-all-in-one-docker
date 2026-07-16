.PHONY: docker-build docker-run docker-shell docker-rm

docker-build:
	docker build --load --build-arg CACHEBUST=$(shell date +%s) -t juice-shop .

docker-run:
	docker run -d --name juice-shop -p 3000:3000 \
		-e BOBSHELL_API_KEY=$(BOB_API_KEY) \
		-v $(shell pwd)/scan-results:/scan-results \
		juice-shop

docker-shell:
	docker exec -it juice-shop bash

docker-rm:
	docker rm -f juice-shop

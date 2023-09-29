SHELL := /bin/bash

.PHONY: all run stop
all: run
run: cypress playwright
stop: stop-server stop-dashboard clean-env-placeholders
cypress: generate-docker-compose-cypress start-server-cypress prepare-server run-cypress
cypress-cloud: create-cloud-customer cypress delete-cloud-customer
playwright: generate-docker-compose-playwright start-server-playwright run-playwright
playwright-cloud: create-cloud-customer playwright delete-cloud-customer

.PHONY: generate-docker-compose-cypress generate-docker-compose-playwright start-server prepare-server run-cypress stop-server restart-server start-server-playwright run-playwright
generate-docker-compose-cypress:
	bash ./.ci/docker_compose_generator.sh cypress
start-server-cypress:
	bash ./.ci/server.start.sh cypress
prepare-server:
	bash ./.ci/server.prepare.sh
run-cypress:
	bash ./.ci/server.run_cypress.sh
stop-server-cypress:
	bash ./.ci/server.stop.sh cypress

generate-docker-compose-playwright:
	bash ./.ci/docker_compose_generator.sh playwright
start-server-playwright:
	bash ./.ci/server.start.sh playwright
run-playwright:
	bash ./.ci/server.run_playwright.sh
stop-server-playwright:
	bash ./.ci/server.stop.sh playwright

start-server:
	bash ./.ci/server.start.sh
stop-server:
	bash ./.ci/server.stop.sh
restart-server: stop-server start-server

.PHONY: start-dashboard stop-dashboard
start-dashboard:
	bash ./.ci/dashboard.start.sh
stop-dashboard:
	bash ./.ci/dashboard.stop.sh

.PHONY: print-env-placeholders clean-env-placeholders
print-env-placeholders:
	find .ci -maxdepth 1 -name '.env.*'  | xargs --verbose -l cat
clean-env-placeholders:
	git reset .ci/.env.{cypress,server,dashboard}
	git checkout .ci/.env.{cypress,server,dashboard}

.PHONY: create-cloud-customer delete-cloud-customer
create-cloud-customer:
	bash ./.ci/server.cloud_customer_create.sh
delete-cloud-customer:
	bash ./.ci/server.cloud_customer_delete.sh

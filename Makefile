include ./config/dev.env
# Frontend make file context
FRONTEND_CONTEXT = make -f frontend.mk
SERVER_CONTEXT = make -f server.mk

INFO = "\033[32m[INFO]\033[0m"

clean:
	@echo $(INFO) "Cleaning project..."
	$(FRONTEND_CONTEXT) clean
	$(SERVER_CONTEXT) clean
	@echo $(INFO) "Complete. Run 'make setup' to install dependencies"

setup: setup-frontend
	@echo $(INFO) "Installing MIX dependencies..."
	$(SERVER_CONTEXT) setup
	@echo $(INFO) "Complete. Run 'make start' to start server"

setup-frontend:
	$(FRONTEND_CONTEXT) setup

compile:
	$(SERVER_CONTEXT) compile

start:
	$(SERVER_CONTEXT) start

lint:
	$(FRONTEND_CONTEXT) lint
	$(SERVER_CONTEXT) lint
	@echo $(INFO) "Complete"

check:
	$(FRONTEND_CONTEXT) check
	$(SERVER_CONTEXT) check

.PHONY: test
test:
	MIX_ENV=test mix test test/ lib/

functional-test:
	$(SERVER_CONTEXT) functional-test &
	$(FRONTEND_CONTEXT) test
	@kill -9 $$(lsof -t -i :4000) # todo: remove port

quality:
	@make lint
	@make check
	@make test

tunnel:
	ssh -p 443 -R0:127.0.0.1:4000 -o StrictHostKeyChecking=no -o ServerAliveInterval=30 9EEyfGe46Y2@a.pinggy.io

db-up:
	@mix ecto.migrate up

db-down:
	@mix ecto.rollback --all

db-rebuild: 
	@make db-down
	@make db-up
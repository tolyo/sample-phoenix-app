clean:
	@rm -rf node_modules

setup:
	@echo $(INFO) "Installing NPM dependencies..."
	@npm i web

lint:
	@echo $(INFO) "Formatting Js/CSS"
	@npm run format
	@echo $(INFO) "Linting Js"
	@npm run lint
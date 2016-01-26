.PHONY: all
all: dependencies test

.PHONY: dependencies
dependencies:
	which node npm >/dev/null 2>&1
	npm install

.PHONY: test
test:
	npm test

.PHONY: run
run:
	node src/main.js

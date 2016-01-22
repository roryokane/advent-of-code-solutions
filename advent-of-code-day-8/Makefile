all: dependencies test

test:
	npm test

test-watch:
	npm run karma

run:
	node src/kata.js

dependencies:
	which node npm phantomjs
	npm install

.PHONY: all dependencies test

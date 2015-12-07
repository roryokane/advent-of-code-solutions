.PHONY: all
all: dependencies test

.PHONY: dependencies
dependencies:
	which bundle || gem install bundler
	bundle check || bundle install

.PHONY: test
test:
	bundle exec ruby test/*_test.rb

.PHONY: repl
repl:
	bundle exec irb

.PHONY: run
run:
	bundle exec ruby lib/main.rb

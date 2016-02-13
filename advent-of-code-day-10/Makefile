MAIN_BINARY = main.native
TEST_BINARY = test.native

.PHONY: default
default: test

$(MAIN_BINARY): src/*
	corebuild src/$(MAIN_BINARY)

.PHONY: run
run: $(MAIN_BINARY) src/*
	./$(MAIN_BINARY)

$(TEST_BINARY): test/* src/*
	corebuild -package oUnit -I src/ test/$(TEST_BINARY)

.PHONY: test
test: $(TEST_BINARY)
	./$(TEST_BINARY)

.PHONY: clean
clean:
	rm -rf _build/ $(MAIN_BINARY) $(TEST_BINARY)

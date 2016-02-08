MAIN_MODULE_NAME = main
TEST_MODULE_NAME = test

MAIN_SRC_FILE = $(MAIN_MODULE_NAME).ml
TEST_FILE = $(TEST_MODULE_NAME).ml

MAIN_BINARY = $(MAIN_MODULE_NAME).native
TEST_BINARY = $(TEST_MODULE_NAME).native

.PHONY: all
all: test

# make this phony to force a recompile, since this Makefile doesn't know all of the dependencies - corebuild infers them
.PHONY: $(MAIN_BINARY)
$(MAIN_BINARY): $(MAIN_SRC_FILE)
	corebuild $(MAIN_BINARY)

.PHONY: run
run: $(MAIN_BINARY)
	./$(MAIN_BINARY)

# make this phony to force a recompile, since this Makefile doesn't know all of the dependencies - corebuild infers them
.PHONY: $(TEST_BINARY)
$(TEST_BINARY): $(MAIN_SRC_FILE) $(TEST_FILE)
	corebuild -package oUnit $(TEST_BINARY)

.PHONY: test
test: $(TEST_BINARY)
	./$(TEST_BINARY)

.PHONY: clean
clean:
	rm -rf *.cache *.cm* *.log *.o *.out $(MAIN_BINARY) $(TEST_BINARY)

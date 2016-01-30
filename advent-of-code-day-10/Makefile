MODULE_NAME  = foo

SRC_FILE     = $(MODULE_NAME).ml
TEST_FILE    = test.ml

DIST_BINARY  = $(MODULE_NAME).out
TEST_BINARY  = test.out

COVERAGE_DIR = coverage/

all: test

$(DIST_BINARY): $(SRC_FILE)
	ocamlfind ocamlopt -g -linkpkg -thread -package core $(SRC_FILE) -o $(DIST_BINARY)

run: $(DIST_BINARY)
	./$(DIST_BINARY)

$(TEST_BINARY): $(SRC_FILE) $(TEST_FILE)
	ocamlfind ocamlopt -g -package oUnit,bisect,core -linkpkg -thread -syntax camlp4o $(SRC_FILE) $(TEST_FILE) -o $(TEST_BINARY)

test: $(TEST_BINARY)
	rm -rf bisect*.out $(COVERAGE_DIR)
	./$(TEST_BINARY)
	bisect-report bisect0001.out -html $(COVERAGE_DIR)

clean:
	rm -rf *.cache *.cm* *.log *.o *.out $(DIST_BINARY) $(TEST_BINARY) $(COVERAGE_DIR)

.PHONY: all, run, test, clean

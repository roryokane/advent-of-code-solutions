# Advent of Code, day 10

[![Project Status: Inactive – The project has reached a stable, usable state but is no longer being actively developed; support/maintenance will be provided as time allows.](http://www.repostatus.org/badges/latest/inactive.svg)](http://www.repostatus.org/#inactive)

For http://adventofcode.com/day/10.

This project was based on [ocaml-boilerplate](https://github.com/yuanqing/ocaml-boilerplate), but the build system and project layout were heavily modified. I made the build system use `corebuild` so I could have multiple source files, I added a `run` build target, and I removed the generation of test coverage reports. Additionally, I moved the `.ml` files into `src/` and `test/` folders both for organization and to simplify the Makefile.

## Setup

Install [OPAM](https://opam.ocaml.org/doc/Install.html). Then do:

```
$ opam install ounit core
```

## Usage

To run the tests in `test/test.ml`, do:

```
$ make test
```

To run the program that reads input and outputs the answer, do:

```
$ make run
```

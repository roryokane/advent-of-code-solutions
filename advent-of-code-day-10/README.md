# ocaml-boilerplate [![Version](https://img.shields.io/badge/version-v0.1.0-orange.svg?style=flat)](https://github.com/yuanqing/ocaml-boilerplate/releases) [![Build Status](https://img.shields.io/travis/yuanqing/ocaml-boilerplate.svg?branch=master&style=flat)](https://travis-ci.org/yuanqing/ocaml-boilerplate)

> A boilerplate for writing [OCaml](https://ocaml.org) modules, with [OUnit](http://ounit.forge.ocamlcore.org) for tests and [Bisect](http://bisect.x9c.fr) for code coverage, plus integration with [Travis-CI](https://travis-ci.org).

## Setup

Install [OPAM](https://opam.ocaml.org/doc/Install.html). Then do:

```
$ opam install bisect ounit
```

## Usage

To run [`test.ml`](https://github.com/yuanqing/ocaml-boilerplate/blob/master/test.ml) and output coverage reports to `coverage/`, simply do:

```
$ make
```

The module name and various paths/files are all specified at the top of the [Makefile](https://github.com/yuanqing/ocaml-boilerplate/blob/master/Makefile).

## Changelog

- 0.1.0
  - Initial release

## License

[MIT](https://github.com/yuanqing/ocaml-boilerplate/blob/master/LICENSE)

Overview
========

instrumentor is intended to make it super easy to wrap modules in additional behavior.

instrumentor only works for modules that expose a single function which returns a promise.

How to use
==========

First we need to get an instrumentor:

```javascript
  var instrumentor = require('instrumentor')
```

Add instruments
---------------

instrumentor follows express's lead. instrumentor uses instruments, so you call `use` to add
them. 

__PLEASE NOTE__ _instrumentor's instrument list is global_

```javascript
  var logger   = require('logging_module')
  var profiler = require('profiler_module')

  instrumentor.use(logger)
  instrumentor.use(profiler)
```

Wrap a module
-------------

the `wrap` method returns an instrumented module, wrapped in all used instruments. The returned
module behaves as expected - instrument's behaviors are transparent to the caller.

```javascript
  var instrumented_module = instrumentor.wrap('raw_module')

  var raw_module_output = instrumented_module(args)
```

What is an instrument?
======================

An instrument is module defines some behavior around promise events and returns a promise.
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

Call `use` to add an instrument.

__PLEASE NOTE__ _the instrument list is global_

```javascript
  var logger   = require('logging_module')
  var profiler = require('profiler_module')

  instrumentor.use(logger)
  instrumentor.use(profiler)
```

Instrument a module
-------------

the `instrument` method returns an instrumented module, wrapped in all used instruments. The returned
module behaves as expected - instrument's behaviors are transparent to the caller.

```javascript
  var instrumented_module = instrumentor.instrument('raw_module')

  var raw_module_output = instrumented_module(args)
```

What is an instrument?
======================

An instrument is module defines some behavior around promise events. instruments for not need to 
return a promise - they simply need to understand how to handle promise events (`resolve`, `reject`, and `update`) as well as the `request` event. `request` is the event that kicks off a module's invokation.
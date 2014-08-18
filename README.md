Overview
--------

instrumentor is intended to make it super easy to wrap modules in additional behavior.

instrumentor only works for modules that expose a single function which returns a promise.

How to use
----------

First we need to get an instrumentor:

```javascript
	var instrumentor = require('instrumentor')
```
Overview
--------

Initialization
--------------

	q 		 	  	= require 'q'
	instruments = [ ]

instrument
----------

	instrument = (module) -> wrap module, require module

wrap
----

	wrap = (module) ->
		(message) ->
			deferred = q.defer()
			
			module message
				.then 		(result) -> process 'resolve', result
				.fail 		(err	 ) -> process 'reject',  err
				.progress (update) -> process 'notify',  update

			for instrument in instruments
				instrument status: 'request', data: message

			process = (status, output) ->
				deferred[status] output
							
				for instrument in instruments
					instrument status: status, data: output

			deferred.promise

use
---

	use = (instrument) -> instruments.push instrument

Public interface
----------------

	module.exports =
		instrument: instrument
		use: 				use
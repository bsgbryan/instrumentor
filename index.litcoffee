Overview
--------

Initialization
--------------

    q           = require 'q'
    instruments = [ ]

instrument
----------

    instrument = (thing) -> wrap require thing

wrap
----

    wrap = (module) ->
      (message) ->
        deferred = q.defer()
        
        module message
          .then     (result) -> process 'resolve', result
          .fail     (err   ) -> process 'reject',  err
          .progress (update) -> process 'notify',  update

        for instrument in instruments
          instrument status: 'request', data: message

        process = (status, output) ->
          deferred[status] output
                
          for instrument in instruments
            data = status: status, data: output

            data.action = message.action if message.action
            
            instrument data

        deferred.promise

use
---

    use = (instrument) -> instruments.push instrument

Public interface
----------------

    module.exports =
      instrument: instrument
      use:        use
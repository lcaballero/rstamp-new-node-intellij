async = require('async')
proc  = require 'child_process'
spawn = proc.spawn
path  = require('path')


module.exports =
  run : (opts, _done) ->

    { options, commands, target } = opts or {}

    options       ?= {}
    options.cwd   ?= path.resolve(process.cwd(), target)
    options.stdio ?= [ process.stdin, process.stdout, process.stderr ]

    handleClose = (next) -> (code, signal) ->
      if code isnt 0
        next(new Error("code: #{code}, signal: #{signal}"))
      else if next? and code is 0
        next(null, code)

    handleProc = (e, cb) ->
      #      cmd = _.flatten([ e.name, e.args ]).join(" ")
      #      console.log('Command:', cmd)

      proc = spawn(e.name, e.args, options)
      proc.on('exit', handleClose(cb))

    async.mapSeries(commands, handleProc, (err, res) ->
      if err? then _done(err, null)
      else _done(null, res)
    )
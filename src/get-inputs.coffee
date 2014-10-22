qu        = require('inquirer')
_         = require('lodash')
path      = require('path')
Gen       = require('./generator')


questions = ->
  projectName = path.basename(process.cwd())
  [
    {
      name    : "target"
      type    : "input"
      message : "Where would you like to write the project?"
      default : "#{process.cwd()}"
    }
    {
      name    : "projectName"
      type    : "input"
      message : "Where would you like to write the project?"
      default : projectName
    }
  ]


module.exports = ->
  qu.prompt(questions(), (answers) ->

    opts = _.defaults({}, {
      target: answers.target
      source: path.resolve(__dirname, "../files/sources/s1")
    }, answers)

    Gen(opts)()
  )


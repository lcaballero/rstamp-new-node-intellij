Gen     = require('../src/generator')
path    = require('path')
fs      = require('fs')
{ run } = require('./ProcessHelpers')


describe 'generator-tests =>', ->

  contains = (root, file, content) ->
    f = path.resolve(root, file)
    c = fs.readFileSync(f, { encoding: 'utf8' }).toString()
    re = new RegExp(content)
    expect(re.test(c)).to.be.true

  exists = (root, dirs...) ->
    for dir in dirs
      file = path.resolve(root, dir)
      expect(fs.existsSync(file), 'should have created file: ' + file).to.be.true

  rm = (cwd, t, cb) ->
    cmds =
      target : cwd
      commands: [ { name: 'rm', args: ['-rf', t] } ]
    run(cmds, cb)

  describe "generate =>", ->

    source      = 'files/sources/s1'
    target      = 'files/targets/t1'
    projectName = 'new-project-name'

    createInputs = ->
      source      : source
      target      : target
      projectName : projectName

    beforeEach ->
      Gen(createInputs(), true)()

    afterEach (done) ->
      rm target, '.idea', done
#      done()

    it 'should have created the site/', ->
      exists(target,
        '.idea'
        '.idea/copyright'
        '.idea/libraries'
        '.idea/scopes'
        '.idea/compiler.xml'
        '.idea/encodings.xml'
        '.idea/jsLibraryMappings.xml'
        '.idea/misc.xml'
        '.idea/modules.xml'
        '.idea/vcs.xml'
        '.idea/workspace.xml'

        '.idea/copyright/profiles_settings.xml'
        '.idea/scopes/scope_settings.xml'
        ".idea/libraries/#{projectName}.xml"
        ".idea/#{projectName}.iml"
      )

    it 'should have interpolated the projectName', ->
      contains(target, '.idea/.name', projectName)

    it 'should have interpolated the projectName', ->
      contains(target, ".idea/libraries/#{projectName}.xml", projectName)

    it 'should rename the .iml file', ->
      contains(target, ".idea/#{projectName}.iml", projectName)


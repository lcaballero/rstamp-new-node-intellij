Gen     = require('rubber-stamp')
path    = require('path')
fs      = require('fs')


module.exports = (opts, isTesting) ->

  { source, target, projectName } = opts

  gen = Gen.using(source, target, opts, "Creates a stub of a Node IntelliJ project.")
    .mkdirs(
      '.idea'
      '.idea/copyright'
      '.idea/libraries'
      '.idea/scopes'
    )
    .translate('idea/compiler.xml',                     '.idea/compiler.xml')
    .translate('idea/encodings.xml',                    '.idea/encodings.xml')
    .translate('idea/jsLibraryMappings.xml',            '.idea/jsLibraryMappings.xml')
    .translate('idea/misc.xml',                         '.idea/misc.xml')
    .translate('idea/modules.xml',                      '.idea/modules.xml')
    .translate('idea/vcs.xml',                          '.idea/vcs.xml')
    .translate('idea/workspace.xml',                    '.idea/workspace.xml')
    .translate('idea/copyright/profiles_settings.xml',  '.idea/copyright/profiles_settings.xml')
    .translate('idea/scopes/scope_settings.xml',        '.idea/scopes/scope_settings.xml')
    .translate('idea/name.ftl',                         '.idea/.name')
    .translate('idea/copyright/profiles_settings.xml',  '.idea/copyright/profiles_settings.xml')
    .translate('idea/scopes/scope_settings.xml',        '.idea/scopes/scope_settings.xml')

    .translate('idea/libraries/name_modules.xml.ftl',   ".idea/libraries/#{projectName}.xml")
    .translate('idea/project.iml.ftl',                  ".idea/#{projectName}.iml")

  ->
    nogen = path.resolve(opts.target, ".rstamp.nogen")

    if fs.existsSync(nogen)
      console.log("#{nogen} file is present in target directory.")
      console.log("Aborting generation.")
    else
      gen.apply()


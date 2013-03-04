Snockets = require 'snockets'

#
# GET home page.
#

scriptsMap = (manifest)->
  snockets = new Snockets()
  snockets.scan manifest, async: false, (err, depGraph) ->
    console.log err if err
    Object.keys(depGraph.map)

scripts = (manifest)->
  scriptList = Object.keys(scriptsMap(manifest).map)
  scriptList = scriptList.map (path)->
    path = path.replace('app/assets/coffee', 'js')
    path = path.replace('.coffee', '.js')
    path = path.replace('public/', '')

exports.index = (req, res)->
  res.render 'index',
    title: "Dean's Site"
    scripts: scripts('./app/assets/coffee/test.coffee')

exports.index2 = (req, res)->
  res.render 'index2',
    title: "Dean's Site"
    scripts: scripts('./app/assets/coffee/manifest.coffee')

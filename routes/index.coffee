Snockets = require 'snockets'

#
# GET home page.
#

scriptsMap = ->
  snockets = new Snockets()
  snockets.scan './app/assets/coffee/manifest.coffee', async: false, (err, depGraph) ->
    console.log err if err
    #console.log Object.keys(depGraph.map)
    Object.keys(depGraph.map)

scripts = ->
  scriptList = Object.keys(scriptsMap().map)
  scriptList = scriptList.map (path)->
    path = path.replace('app/assets/coffee', 'js')
    path = path.replace('.coffee', '.js')
    path = path.replace('public/', '')

exports.index = (req, res)->
  res.render 'index',
    title: "Dean's Site"

exports.index2 = (req, res)->
  res.render 'index2',
    title: "Dean's Site"
    scripts: scripts()

Snockets = require 'snockets'

settings = require '../app/settings'
goodreads = require('../lib/goodreads') settings.goodreads
lastfm = require('../lib/lastfm') settings.lastfm
githubClient = require('../lib/github') settings.github
twitterClient = require('../lib/twitter') settings.twitter

scriptsMap = (manifest)->
  snockets = new Snockets()
  snockets.scan manifest, async: false, (err, depGraph) ->
    console.log err if err
    Object.keys(depGraph.map)

scripts = (manifest)->
  scriptList = Object.keys(scriptsMap(manifest).map)
  scriptList = scriptList.map (path)->
    path.replace('app/assets/coffee', 'js')
      .replace('.coffee', '.js')
      .replace('public/', '')

exports.index = (req, res)->
  res.render 'index',
    title: "Dean's Site"
    scripts: scripts('./app/assets/coffee/manifest.coffee')

exports.goodreads = (req, res) ->
  shelfId = 21538062
  goodreads.getUser 6540398, (user)->
    goodreads.getShelfForUser user, 'read', (userWithShelves)->
      res.set('Content-Type', 'application/json')
      res.send userWithShelves

exports.lastfm = (req, res) ->
  lastfm.getRecentTracksForUser 'il1019', (trackListResponse)->
    res.set('Content-Type', 'application/json')
    res.send trackListResponse.body

exports.twitter = (req, res) ->
  twitterClient.getRecentTweetsForUser 'pleiadeez', (tweetResponse)->
    res.set('Content-Type', 'application/json')
    res.send tweetResponse.body

exports.github = (req, res) ->
  githubClient.getRecentEventsForUser 'pleiadeez', (githubResponse)->
    res.set('Content-Type', 'application/json')
    res.send githubResponse.body

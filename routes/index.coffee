
#
# GET home page.
#

exports.index = (req, res)->
  res.render 'index',
    title: "Dean's Site"

exports.index2 = (req, res)->
  res.render 'index2',
    title: "Dean's Site"

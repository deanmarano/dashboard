
#
# GET home page.
#

exports.index = (req, res)->
  res.render 'index',
    title: "Dean's Site"


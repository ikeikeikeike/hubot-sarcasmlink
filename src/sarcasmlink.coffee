# Description:
#   Sarcasm link for hubot.
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   hubot (en|ja) sarcasmlink (gif|png|jpg|json) - Grab a random image from http://sarcasm.link
#
# Author:
#   ikeikeikeike

module.exports = (robot) ->
  robot.respond /((ja|en) +)?sarcasmlink( +(gif|png|jpg|json))?/i, (msg) ->
    if msg.match[2]
      sarcasmMe msg, msg.match[2], (url) ->
        msg.send url
    else
      sarcasmMe msg, 'ja', (one) -> sarcasmMe msg, 'en', (two) ->
        msg.send msg.random([one, two])

sarcasmMe = (msg, lang, cb) ->
  msg.http("http://sarcasm.link/#{lang}/random.json")
    .get() (err, res, body) ->
      try
        cb JSON.parse(body).shorten_url
      catch error
        cb body

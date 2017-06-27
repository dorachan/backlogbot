# Description:
#   LGTM
#
# Commands:
#   hubot LGTM - LGTM
#   hubot lgtm register <URL> - register a new LGTM

BRAIN_KEY = 'lgtm'

module.exports = (robot) ->
  robot.hear /lgtm register (http.+)/i, (msg) ->
    image = msg.match[1]
    images = robot.brain.get(BRAIN_KEY) or []
    images.push image
    robot.brain.set(BRAIN_KEY, images)

    msg.send "LGTM Registered"

  robot.hear /lgtm(?:\s*)$/i, (msg) ->
    default_images = [
      'https://raw.githubusercontent.com/rela1470/lgtm/master/momoka/momoka_22.jpg',
      'https://u215682.dl.dropboxusercontent.com/u/215682/non-lgtm.png',
      'http://68.media.tumblr.com/c35dd400164d15970a0afe73b131a779/tumblr_or9xt6g2p91ub5poho1_250.jpg',
      'https://i.gyazo.com/a5461fbbc35cc4ecf02738fdfbe1cd06.gif'
    ]

    images = default_images.concat(robot.brain.get(BRAIN_KEY) || [])

    msg.send msg.random images

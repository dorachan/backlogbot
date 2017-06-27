# Description:
#   unixtime(milliseconds) to JST
#
# Commands:
#   hubot unixtime 1234567

moment = require ('moment-timezone')

module.exports = (robot) ->

  robot.hear /unixtime (\d*)/i, (res) ->
    moment.locale('ja')
    ut = parseInt(res.match[1])
    dt = moment(ut).tz('Asia/Tokyo').format()
    res.send "Time is #{dt}"
    
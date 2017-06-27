# Description:
#   get NHK WORLD Program Guide
#
# Commands:
#   hubot now on air
#   hubot next on air

module.exports = (robot) ->
  robot.hear /(now|next) on air/i, (res) ->
    num = if res.match[1] is "now" then 0 else 1
    url = "https://api.nhk.or.jp/nhkworld/epg/v7/jstrm/now.json"
    apikey = "?apikey=EJfK8jdS57GqlupFgAfAAwr573q01y6k"
    robot.http(url + apikey)
      .get() (err, response, body) ->
        if err
          res.send "Encountered an error :( #{err}"
          return
        if response.statusCode isnt 200
          res.send "Request didn't come back HTTP 200 :("
          return
        now = JSON.parse(body).channel.item[num]
        thumbnail = now.thumbnail_s
        if /^\//.test(thumbnail)
          thumbnail = "https://www3.nhk.or.jp" + thumbnail
        msg = "#{thumbnail}\n*#{now.title}* #{now.subtitle}"
        if now.content_clean
          msg += "\n```\n#{now.content_clean}\n```"
        res.send msg
        return

# Description:
#   now on air
#
# Commands:
#   hubot now on air

module.exports = (robot) ->
  robot.hear /now on air/i, (res)->
    url = 'https://api.nhk.or.jp/nhkworld/epg/v7/jstrm/now.json'
    apikey = '?apikey=EJfK8jdS57GqlupFgAfAAwr573q01y6k'
    robot.http(url + apikey).get() (err, resp, body)->
      if err
        res.send "API Error: #{err}"
        return
      now = JSON.parse(body).channel.item[0]
      title = now.title
      subtitle = now.subtitle
      content = now.content_clean
      thumbnail = 'https://www3.nhk.or.jp' + now.thumbnail_s
      res.send "*#{title}* #{subtitle}\n```\n#{content}\n```\n#{thumbnail}"
      return

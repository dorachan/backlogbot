# Description:
#   now on air
#
# Commands:
#   hubot now on air

module.exports = (robot) ->
  robot.hear /now on air/i, (res) ->
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
      mes = thumbnail + "\n*#{title}* #{subtitle}"
      if content
        mes += "\n```\n#{content}\n```"
      res.send mes
      return

  robot.hear /next on air/i, (res) ->
    url = 'https://api.nhk.or.jp/nhkworld/epg/v7/jstrm/now.json'
    apikey = '?apikey=EJfK8jdS57GqlupFgAfAAwr573q01y6k'
    robot.http(url + apikey).get() (err, resp, body)->
      if err
        res.send "API Error: #{err}"
        return
      now = JSON.parse(body).channel.item[1]
      title = now.title
      subtitle = now.subtitle
      content = now.content_clean
      thumbnail = 'https://www3.nhk.or.jp' + now.thumbnail_s
      mes = thumbnail + "\n*#{title}* #{subtitle}"
      if content
        mes += "\n```\n#{content}\n```"
      res.send mes
      return

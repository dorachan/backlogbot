module.exports = (robot) ->
  robot.hear /\b([1-9]\d{0,2}|0)ちゃい/, (msg) ->
    now = new Date()
    year = now.getFullYear()
    birth = parseInt(msg.match[1].replace(/ちゃい/g, ""));
    answer = year - birth
    msg.send "#{msg.message.user.name} さんは #{answer} 年生まれ！"

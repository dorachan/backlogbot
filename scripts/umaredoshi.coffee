module.exports = (robot) ->
  robot.hear /\b([1-9]\d{0,2}|0)ちゃい/, (msg) ->
    now = new Date()
    year = now.getFullYear()
    birth = parseInt(msg.match[1].replace(/ちゃい/g, ""));
    answer = year - birth
    msg.send "#{msg.message.user.name} さんは #{answer} 年生まれ！"
  robot.hear /\b([1-9][0][0][1-9]\d{0,2})ちゃい/, (msg) ->
    msg.send "#フハハハハハ！お前を蝋人形にしてやろうか！\n https://upload.wikimedia.org/wikipedia/commons/thumb/5/5a/Seikima-II_20100704_Japan_Expo_73.jpg/440px-Seikima-II_20100704_Japan_Expo_73.jpg"

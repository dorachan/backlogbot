module.exports = (robot) ->
  robot.hear /\b([1-9]\d*|0)ちゃい/, (msg) ->
    now = new Date()
    year = now.getFullYear()
    age = parseInt(msg.match[1].replace(/ちゃい/g, ""));
    if age >= 100000
      msg.send "フハハハハハ！お前を蝋人形にしてやろうか！\n https://upload.wikimedia.org/wikipedia/commons/thumb/5/5a/Seikima-II_20100704_Japan_Expo_73.jpg/440px-Seikima-II_20100704_Japan_Expo_73.jpg"
    else if age < 1000
      answer = year - age
      msg.send "#{msg.message.user.name} さんは #{answer} 年生まれ！"

# Commands:
#   hubot <age>ちゃい

module.exports = (robot) ->
  robot.hear /\b([1-9]\d*|0)ちゃい/, (msg) ->
    now = new Date()
    year = now.getFullYear()
    age = parseInt(msg.match[1].replace(/ちゃい/g, ""))
    if age >= 100000
      msg.send "フハハハハハ！お前を蝋人形にしてやろうか！\n https://upload.wikimedia.org/wikipedia/commons/thumb/5/5a/Seikima-II_20100704_Japan_Expo_73.jpg/440px-Seikima-II_20100704_Japan_Expo_73.jpg"
    else if age < 1000
      msg.reply "今年の誕生日は過ぎましたか？（うん／まだ）"
      robot.hear /\b(うん|まだ)/, (msg) ->
        if msg.match[1] is "うん"
          birth = year - age
          msg.reply "さんは #{birth} 年生まれ！"
        else if msg.match[1] is "まだ"
          birth = year - age - 1
          msg.reply "さんは #{birth} 年生まれ！"

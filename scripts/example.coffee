# Description:
#   Example scripts for you to examine and try out.
#
# Notes:
#   They are commented out by default, because most of them are pretty silly and
#   wouldn't be useful and amusing enough for day to day huboting.
#   Uncomment the ones you want to try and experiment with.
#
#   These are from the scripting documentation: https://github.com/github/hubot/blob/master/docs/scripting.md

moment = require ('moment-timezone')

module.exports = (robot) ->

  robot.hear /unixtime (\d*)/i, (res) ->
    moment.locale('ja');
    ut = parseInt(res.match[1]);
    dt = moment(ut).tz('Asia/Tokyo').format()
    res.send "Time is #{dt}"

  robot.hear /badger/i, (res) ->
    res.send "Badgers? BADGERS? WE DON'T NEED NO STINKIN BADGERS"
  #
  robot.respond /open the (.*) doors/i, (res) ->
    doorType = res.match[1]
    if doorType is "pod bay"
      res.reply "I'm afraid I can't let you do that."
    else
      res.reply "Opening #{doorType} doors"
  #
  robot.hear /I like pie/i, (res) ->
    res.emote "makes a freshly baked pie"
  #
  lulz = ['lol', 'rofl', 'lmao']
  #
  robot.respond /lulz/i, (res) ->
    res.send res.random lulz
  #
  robot.topic (res) ->
    res.send "#{res.message.text}? That's a Paddlin'"
  #
  #
  enterReplies = ['Hi', 'Target Acquired', 'Firing', 'Hello friend.', 'Gotcha', 'I see you']
  leaveReplies = ['Are you still there?', 'Target lost', 'Searching']
  #
  robot.enter (res) ->
    res.send res.random enterReplies
  robot.leave (res) ->
    res.send res.random leaveReplies
  #
  answer = process.env.HUBOT_ANSWER_TO_THE_ULTIMATE_QUESTION_OF_LIFE_THE_UNIVERSE_AND_EVERYTHING
  #
  robot.respond /what is the answer to the ultimate question of life/, (res) ->
    unless answer?
      res.send "Missing HUBOT_ANSWER_TO_THE_ULTIMATE_QUESTION_OF_LIFE_THE_UNIVERSE_AND_EVERYTHING in environment: please set and try again"
      return
    res.send "#{answer}, but what is the question?"
  #
  robot.respond /you are a little slow/, (res) ->
    setTimeout () ->
      res.send "Who you calling 'slow'?"
    , 60 * 1000
  #
  annoyIntervalId = null
  #
  robot.respond /annoy me/, (res) ->
    if annoyIntervalId
      res.send "AAAAAAAAAAAEEEEEEEEEEEEEEEEEEEEEEEEIIIIIIIIHHHHHHHHHH"
      return
  #
    res.send "Hey, want to hear the most annoying sound in the world?"
    annoyIntervalId = setInterval () ->
      res.send "AAAAAAAAAAAEEEEEEEEEEEEEEEEEEEEEEEEIIIIIIIIHHHHHHHHHH"
    , 1000
  #
  robot.respond /unannoy me/, (res) ->
    if annoyIntervalId
      res.send "GUYS, GUYS, GUYS!"
      clearInterval(annoyIntervalId)
      annoyIntervalId = null
    else
      res.send "Not annoying you right now, am I?"
  #
  #
  robot.router.post '/hubot/chatsecrets/:room', (req, res) ->
    room   = req.params.room
    data   = JSON.parse req.body.payload
    secret = data.secret
  #
    robot.messageRoom room, "I have a secret: #{secret}"
  #
    res.send 'OK'
  #
  robot.error (err, res) ->
    robot.logger.error "DOES NOT COMPUTE"
  #
    if res?
      res.reply "DOES NOT COMPUTE"
  #
  robot.respond /have a soda/i, (res) ->
    # Get number of sodas had (coerced to a number).
    sodasHad = robot.brain.get('totalSodas') * 1 or 0
  #
    if sodasHad > 4
      res.reply "I'm too fizzy.."
  #
    else
      res.reply 'Sure!'
  #
      robot.brain.set 'totalSodas', sodasHad+1
  #
  robot.respond /sleep it off/i, (res) ->
    robot.brain.set 'totalSodas', 0
    res.reply 'zzzzz'

  robot.respond /(.*) tabetai/i, (res)->
    url = 'https://api.gnavi.co.jp/RestSearchAPI/20150630/?keyid=55e05834a6421bfdcc3e28aeb6b80776&format=json&latitude=35.6656161&longitude=139.69586429999998&range=3&freeword='
    word = encodeURIComponent(res.match[1])
    url += word
    robot.http(url).get() (err, apires, body)->
      if err
        res.send "miss #{err}"
        return
      json = JSON.parse(body)
      rest = json.rest
      len = rest.length
      if rest.length < 1
        res.send "土耕すところから始めるしかない"
      else
        # ランダムにする
        index = Math.random() * len | 0
        res.send rest[index].name + '\n' + rest[index].url
      return

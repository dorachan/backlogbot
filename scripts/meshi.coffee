
module.exports = (robot)->
  #meshi search
  robot.here /(.*) tabetai/i, (res)->
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

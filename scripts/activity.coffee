# Description:
#   Monitors general channel activity and creates a report
#

_ = require('underscore')

cleanUpBrain = (robot) ->
  robot.logger.info "Cleaning my brain"
  dat = robot.brain.data

  users = dat.users
  if users
    for uid of users
      users[uid].slack = {}

    dat.users = users

  robot.brain.data = dat


FLOOD_TIME = 5 # minutes
FLOOD_TRIP = 20 # messages
floodProtect = (robot, room, msg) ->
  exp = (new Date()) - (FLOOD_TIME * 60 * 1000)
  user = "" + msg.message.user.name
  fr = robot.brain.data.flood_rooms
  fr[room] ||= {}
  dat = fr[room]
  dat[user] ||= []
  keep = []
  for time in dat[user]
    keep.push(time) if time > exp

  keep.push((+ new Date()))
  dat[user] = keep
  fr[room] = dat
  robot.brain.data.flood_rooms = fr

  robot.logger.info("#{user}: #{keep.length}")
  if keep.length > FLOOD_TRIP
    msg.reply "Hey there! You've tripped my flood protection system. Please refrain from posting more than #{FLOOD_TRIP} messages within #{FLOOD_TIME} minutes. I will continue to be annoying if you persist :). Thanks!"



module.exports = (robot) ->
  robot.brain.data.flood_rooms ||= {}
  robot.brain.data.activity_rooms ||= {from: (new Date())}

  robot.hear /.*/i, (res) ->
    if Math.random() > 0.90
      cleanUpBrain(robot)

    return unless robot.adapter.client && robot.adapter.client.rtm
    room  = res.message.room                      || "unknown"
    channels = robot.adapter.client.rtm.dataStore.channels
    if channels.hasOwnProperty(room)
      room = channels[room].name
    prior = robot.brain.data.activity_rooms[room] || 0
    robot.brain.data.activity_rooms[room] = prior + 1

    if room == "politics-discussion"
      console.log(res.message)
      console.log(channels[room])
      floodProtect(robot, room, res)

  robot.respond /roomstats/, (res) ->
    data = robot.brain.data.activity_rooms
    reply = ""
    _.chain(data).pairs().sortBy( (v)-> v[1] ).reverse().each (v) ->
      room = v[0]
      num  = v[1]
      channels = robot.adapter.client.rtm.dataStore.channels
      # robot.adapter.client.rtm.dataStore.channels[room].name
      if channels.hasOwnProperty(room)
        room = channels[room].name

      reply += "##{room}: #{num}\n"

    res.send reply

  robot.respond /roomreset/, (res) ->
    robot.brain.data.activity_rooms = {from: (new Date())}
    res.reply "OK"

  robot.respond /channelslist/, (res) ->
    channels_list = robot.adapter.client.rtm.dataStore.channels
    dat = _.chain(channels_list).filter((e) -> !e.is_archived && !e.is_member).map((e) -> e.name).value()
    # hmm slack doesn't allow bots to join right now :(
    #_(dat).each (e) ->
    #  robot.adapter.client.web.channels.join(e)
    res.reply "I need to join #{dat.join(", ")}"

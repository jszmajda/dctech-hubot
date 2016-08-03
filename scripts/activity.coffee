# Description:
#   Monitors general channel activity and creates a report
#

_ = require('underscore')

module.exports = (robot) ->
  robot.brain.data.activity_rooms ||= {from: (new Date())}

  robot.hear /.*/i, (res) ->
    room  = res.message.room                      || "unknown"
    prior = robot.brain.data.activity_rooms[room] || 0
    robot.brain.data.activity_rooms[room] = prior + 1

  robot.respond /roomstats/, (res) ->
    data = robot.brain.data.activity_rooms
    reply = ""
    _.chain(data).pairs().sortBy( (v)-> v[1] ).reverse().each (v) ->
      room = v[0]
      num  = v[1]
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

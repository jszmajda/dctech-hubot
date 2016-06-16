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
    console.log("Set #{room} to #{prior + 1}")

  robot.respond /roomstats/, (res) ->
    data = robot.brain.data.activity_rooms
    _.chain(data).pairs().sortBy( (v)-> v[1] ).reverse().each (v) ->
      room = v[0]
      num  = v[1]
      res.reply "##{room}: #{num}"

  robot.respond /roomreset/, (res) ->
    robot.brain.data.activity_rooms = {from: (new Date())}
    res.reply "OK"


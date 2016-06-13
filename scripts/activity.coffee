# Description:
#   Monitors general channel activity and creates a report
#

module.exports = (robot) ->
  robot.brain.data.activity_rooms ||= {}

  robot.hear /.*/i, (res) ->
    room = res.room || "unknown"
    prior = robot.brain.data.activity_rooms[room] || 0
    robot.brain.data.activity_rooms[room] = prior + 1
    console.log("Set #{room} to #{prior + 1}")

  robot.respond /roomstats/, (res) ->
    res.reply JSON.stringify(robot.brain.data.activity_rooms)

  robot.respond /roomreset/, (res) ->
    robot.brain.data.activity_rooms = {}
    res.reply "OK"


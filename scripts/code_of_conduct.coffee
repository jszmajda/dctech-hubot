module.exports = (robot) ->
  robot.codeOfConduct = [
    "The DCTech Slack Community is dedicated to providing a harassment-free experience for everyone, regardless of gender, gender identity and expression, sexual orientation, disability, physical appearance, body size, race, or religion. We do not tolerate harassment of participants in any form.",
    "This code of conduct applies to all channels. Anyone who violates this code of conduct may be sanctioned or expelled from these spaces at the discretion of the admins.",
    "If you are being harassed by a member of the community, notice that someone else is being harassed, or have any other concerns, please contact Josh Szmajda by direct message, @joshsz. I will respond as promptly as I can."
  ]
  robot.respond /code of conduct/i, (res) ->
    res.send robot.codeOfConduct.join("\n")
    res.send "Also available at #{process.env.HEROKU_URL}code-of-conduct" if process.env.HEROKU_URL

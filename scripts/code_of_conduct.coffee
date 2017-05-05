module.exports = (robot) ->
  robot.codeOfConduct = [
    "The DCTech Slack Community exists to provide a space for individuals who live in the greater DC region to communicate, interact, share interesting ideas, and support each other in achieving their goals.",
    "We hope to create an environment in which all individuals can participate in a positive and affirming way. Behavior that contributes to this sort of environment includes using welcoming and inclusive language, being respectful of differing viewpoints and experiences, gracefully accepting constructive criticism, focusing on what is best for the community at large, and showing empathy towards other community members.",
    "The DCTech Slack Community is committed to providing an experience that is safe and free from harassment or offense for everyone, regardless of personal attributes such as gender, gender identity and expression, sexual orientation, disability, physical appearance, body size, race, or religion. We do not tolerate harassment of participants in any form. We expect members to act in good faith to avoid intentionally offending others",
    "This code of conduct applies to all public and private channels as well as direct messages. Anyone who violates this code of conduct may be sanctioned or expelled from these spaces at the discretion of the admins.",
    "If you are being harassed or offended by a member of the community, notice that someone else is being harassed or offended, or have any other concerns, please contact Josh Szmajda by direct message, @joshsz. I will respond as promptly as I can."
  ]
  robot.respond /code of conduct/i, (res) ->
    res.send robot.codeOfConduct.join("\n")
    res.send "Also available at #{process.env.HEROKU_URL}code-of-conduct" if process.env.HEROKU_URL

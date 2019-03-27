module.exports = (robot) ->
  robot.codeOfConduct = [
    "The DCTech Slack Community exists to provide a space for individuals who live in the greater DC region to communicate, interact, share interesting ideas, and support each other in achieving their goals.",
    "We hope to create an environment in which all individuals can participate in a positive and affirming way. Behavior that contributes to this sort of environment includes using welcoming and inclusive language, being respectful of differing viewpoints and experiences, gracefully accepting constructive criticism, focusing on what is best for the community at large, and showing empathy towards other community members.",
    "The DCTech Slack Community is committed to providing an experience that is safe and free from harassment or offense for everyone, regardless of personal attributes such as gender, gender identity and expression, sexual orientation, disability, physical appearance, body size, race, or religion. We do not tolerate harassment of participants in any form. We expect members to act in good faith to avoid intentionally offending others",
    "This code of conduct applies to all public and private channels as well as direct messages. Anyone who violates this code of conduct may be sanctioned or expelled from these spaces at the discretion of the admins.",
    "If you are being harassed or offended by a member of the community, notice that someone else is being harassed or offended, or have any other concerns, please contact Jess Szmajda by direct message, @jess.sz. I will respond as promptly as I can."
  ]
  robot.respond /code of conduct/i, (res) ->
    res.send robot.codeOfConduct.join("\n")
    res.send "Also available at #{process.env.HEROKU_URL}code-of-conduct" if process.env.HEROKU_URL

  robot.respond /.*(breathe|pause|break)/i, (res) ->
    word = res.random ['conversation', 'debate', 'discussion']
    verb = res.random ['is getting heated', 'is boiling over', 'needs a breather', 'could use a moment to cool down']

    selection = res.random [
      ["a cute parenting moment", "https://g.redditmedia.com/zg_jnZa8EY73SaKM7oaTg49uum9RDVVH-ini2UTYQlo.gif?w=614&fm=mp4&mp4-fragmented=false&s=8f0dd7330f5e7ba20876c717982a4c6c"],
      ["a cute kid and dog", "https://i.imgur.com/sAu7VoV.jpg"],
      ["a melty bird", "https://i.imgur.com/XZN0lDx.jpg"],
      ["some festive cuteness", "https://i.imgur.com/DKAcxzk.jpg"],
      ["a cute doggo and her toy", "https://i.redd.it/figdnt37g2dy.jpg"],
      ["a cat all grown up", "https://i.imgur.com/arVW3Ie.jpg"],
      ["a squishy cat", "https://i.imgur.com/4FpNvS6.jpg"],
      ["a heartwarming moment", "https://i.redd.it/yhp89qgk2b5y.jpg"],
      ["business cat", "https://i.redd.it/esj6kphagqpy.jpg"],
      ["a happy family", "https://i.imgur.com/cfkVhSg.jpg"]
    ]
    ugh_videos = [
      ["a heartwarming rescue", "https://i.imgur.com/A6ap8sw.mp4"],
      ["a lovey husky", "https://i.imgur.com/Sfh711A.mp4"],
      ["an awesome lizard interaction", "https://i.imgur.com/hldiOJk.mp4"],
      ["some boppy cats", "https://i.imgur.com/qecLpkU.mp4"],
      ["a rare tree doggo", "https://i.imgur.com/n5yN6Uo.mp4"],
      ["an amazing wat moment", "https://i.imgur.com/kNmuYXB.mp4"],
      ["a really cute hammock moment", "https://i.imgur.com/6296nk2.mp4"],
      ["a dashing squirrel", "https://i.imgur.com/rZ84RGB.mp4"],
      ["a surprise present", "https://i.imgur.com/nq57pvz.mp4"],
      ["a surpringly deep metaphor", "https://i.imgur.com/1I2L3Yg.mp4"],
      ["a very surprised red panda", "https://fat.gfycat.com/DearestIllinformedBlackbird.webm"]
    ]
    thing = selection[0]
    url = selection[1]
    res.send "This #{word} #{verb}, lets all take 10 and then come back to it\nHere's #{thing} to enjoy during the break:\n#{url}"

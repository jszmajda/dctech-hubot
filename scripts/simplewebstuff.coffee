
module.exports = (robot) ->
  robot.router.get '/code-of-conduct', (req, res) ->
    res.send """
<html>
  <body>
  <h1>Code of Conduct</h1>
  #{("<p>#{e}</p>" for e in robot.codeOfConduct).join("")}
<!-- Credits for this CoC go to the <a href="http://geekfeminism.wikia.com/wiki/Community_anti-harassment/Policy">Geek Feminism Wiki</a> -->
  </body>
</html>
             """

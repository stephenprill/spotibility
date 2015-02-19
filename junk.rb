# require 'faraday'
#
# token = "BQCWoVpOwD_JACHPN4vWPC7eit2t40S1IsY1yA6gIEJwuqIhpsJqy2ijp2ogFJxIVKKFTPLvGGjVjAMDcNkqFGVTe-Er2ct1FBSc3WOudni9tr2zKRy5DUA5KD8HPZ86Qb6itSnEo7Z7EDBIC-O-pt_qCXF9RRr6ZNLYkFrahoI_HueEgKocNWSlanYzJN-xs0BsAxNER-27hA"
# conn = Faraday.new(:url => 'https://api.spotify.com/')
#
# response = conn.get("/v1/me") do |req|
#   req.headers['Authorization'] = "Bearer #{token}"
# end
#
# puts response.body


#
# <iframe src="https://embed.spotify.com/?uri=http://open.spotify.com/user/stephenprill/playlist/0XSXEv7BpxQCS6UC02qciM" width="300" height="380" frameborder="0" allowtransparency="true"></iframe>
#   <br><br><hr>
# <iframe src="https://embed.spotify.com/?uri=http://open.spotify.com/user/stephenprill/playlist/0XSXEv7BpxQCS6UC02qciM" width="300" height="80" frameborder="0" allowtransparency="true"></iframe>
#   <hr><br>

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


track[:id][:track][:name]

=> ["4Z4i2iikPAtEMizEFP1yhR",
 [{:added_at=>"2015-03-15T20:09:07Z",
   :added_by=>{:external_urls=>{:spotify=>"http://open.spotify.com/user/illmerlo"}, :href=>"https://api.spotify.com/v1/users/illmerlo", :id=>"illmerlo", :type=>"user", :uri=>"spotify:user:illmerlo"},
   :track=>
    {:album=>
      {:album_type=>"album",
       :available_markets=>["MX", "US"],
       :external_urls=>{:spotify=>"https://open.spotify.com/album/2R2Cwe4kI8b2WObXZ90wOC"},
       :href=>"https://api.spotify.com/v1/albums/2R2Cwe4kI8b2WObXZ90wOC",
       :id=>"2R2Cwe4kI8b2WObXZ90wOC",
       :images=>
        [{:height=>640, :url=>"https://i.scdn.co/image/d67da7ef8d34e088fc29a3042f7fcf67c9d82133", :width=>640},
         {:height=>300, :url=>"https://i.scdn.co/image/dc96ce667b2b801038563fa6a59f7edcc4d10a1a", :width=>300},
         {:height=>64, :url=>"https://i.scdn.co/image/7200b100928518facc62072b45fabd1c2f0cf309", :width=>64}],
       :name=>"Voices",
       :type=>"album",
       :uri=>"spotify:album:2R2Cwe4kI8b2WObXZ90wOC"},
     :artists=>
      [{:external_urls=>{:spotify=>"https://open.spotify.com/artist/1l9d7B8W0IHy3LqWsxP2SH"},
        :href=>"https://api.spotify.com/v1/artists/1l9d7B8W0IHy3LqWsxP2SH",
        :id=>"1l9d7B8W0IHy3LqWsxP2SH",
        :name=>"Phantogram",
        :type=>"artist",
        :uri=>"spotify:artist:1l9d7B8W0IHy3LqWsxP2SH"}],
     :available_markets=>["MX", "US"],
     :disc_number=>1,
     :duration_ms=>215413,
     :explicit=>false,
     :external_ids=>{:isrc=>"USUM71318569"},
     :external_urls=>{:spotify=>"https://open.spotify.com/track/0zDbbJ71fcLI9E8dmlgffZ"},
     :href=>"https://api.spotify.com/v1/tracks/0zDbbJ71fcLI9E8dmlgffZ",
     :id=>"0zDbbJ71fcLI9E8dmlgffZ",
     :name=>"Bill Murray",
     :popularity=>51,
     :preview_url=>"https://p.scdn.co/mp3-preview/777814e0fc31ea4da566b314f383f1ae956e9890",
     :track_number=>8,

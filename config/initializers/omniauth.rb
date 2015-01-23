Rails.application.config.middleware.use OmniAuth::Builder do
  provider :spotify, "8b1a2f49127e496ba2eae4203127694d", "60cf0492e972495cb4bb1310b6e09802",
  scope: 'user-read-email playlist-modify-public user-library-read user-library-modify'
end

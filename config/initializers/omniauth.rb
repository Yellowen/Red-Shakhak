Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, TWITTER_KEY, TWITTER_SECRET
  provider :google_oauth2, "90531321629.apps.googleusercontent.com", "GJLwQJ0UYGofYyj9GMGSEM_y", { access_type: "offline", approval_prompt: "" }
end

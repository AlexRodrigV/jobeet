Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, '421325538222-k6qb68ol0rnlpv8hehmdobjvjmo0rnn3.apps.googleusercontent.com', 'd6qozkB2criD2JgDap6ag8Ue', skip_jwt: true
end

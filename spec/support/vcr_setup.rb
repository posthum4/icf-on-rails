VCR.configure do |c|
  #the directory where your cassettes will be saved
  c.cassette_library_dir = 'spec/vcr'
  # your HTTP request service. You can also use fakeweb, webmock, and more
  c.hook_into :webmock
  c.ignore_localhost = true
  c.allow_http_connections_when_no_cassette = true
  c.debug_logger = File.open("/Users/rs/ndb_projects/icf-on-rails/log/vcr_debug.log", 'w')
end
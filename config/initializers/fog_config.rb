
aws_bucket = 'media.montgomeryhillsbaptistchurch.com'
if Rails.env.development?
    aws_bucket += '_devel'
end

CarrierWave.configure do |config|
  config.fog_credentials = {
    :provider               => 'AWS',                        # required
#    :aws_access_key_id      => 'AKIAI46VII4QAHASNT2A',                        # required
#    :aws_secret_access_key  => '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',                        # required
    :aws_access_key_id      => ENV['AWS_ACCESS_KEY_ID'],                        # required
    :aws_secret_access_key  => ENV['AWS_SECRET_ACCESS_KEY'],                        # required
    :region                 => 'us-east-1',                  # optional, defaults to 'us-east-1'
#    :host                   => 's3.example.com',             # optional, defaults to nil
#    :endpoint               => 'https://s3.example.com:8080' # optional, defaults to nil
  }
  config.fog_directory  = aws_bucket                        # required
  config.fog_public     = false                                   # optional, defaults to true
#  config.fog_attributes = {'Cache-Control'=>'max-age=315576000'}  # optional, defaults to {}
end

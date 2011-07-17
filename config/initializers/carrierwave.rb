CarrierWave.configure do |config|

  # use fog as storage mechanism
  config.storage = :fog

  # fog configuration
  config.fog_credentials = {
    # AWS settings
    :provider               => ENV['FOG_PROVIDER'],
    :aws_access_key_id      => ENV['AWS_ACCESS_KEY'],
    :aws_secret_access_key  => ENV['AWS_SECRET_KEY'],
    :region                 => ENV['AWS_REGION']
  }
  config.fog_directory  = ENV['AWS_S3_BUCKET']

  # path configuration, suitable for local, dreamhost and heroku
  config.cache_dir      = "#{Rails.root}/tmp/carrierwave"
  config.root           = "#{Rails.public_path}/system"

end
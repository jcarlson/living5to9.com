# tell fog where to look for cloud credentials
Fog.credentials_path = Rails.root.join('config/fog_credentials.yml')

CarrierWave.configure do |config|

  # use fog as storage mechanism
  # config.storage = :fog

  # path configuration, suitable for local, dreamhost and heroku
  config.cache_dir      = "#{Rails.root}/tmp/carrierwave"
  config.root           = "#{Rails.public_path}/system"

end
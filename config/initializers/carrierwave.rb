# tell fog where to look for cloud credentials
Fog.credentials_path = Rails.root.join('config/fog_credentials.yml')

CarrierWave.configure do |config|

  # path configuration, suitable for local, dreamhost and heroku
  config.cache_dir      = "#{Rails.root}/tmp/carrierwave"
  
end
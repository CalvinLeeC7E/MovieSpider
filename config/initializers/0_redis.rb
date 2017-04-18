config = Rails.application.config_for(:redis)
$REDIS = Redis.new(host: config[:host], port: config[:port])

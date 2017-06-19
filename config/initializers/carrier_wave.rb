if Rails.env.production?
  require 'fog/aws'
  require 'carrierwave'
  CarrierWave.configure do |config|
    config.fog_provider = 'fog/aws'
    config.fog_credentials = {
      # Configuration for Amazon S3
      provider: 'AWS',
      aws_access_key_id: ENV['f4c9c1137bd3191d128bcd53a7fef5bc0d5f7ea7186b62c3b4ecdafd42d19520e11294aadaf6a76a5d53f2b84d0b6d767ac62bd555a9706d04c6f778668a5c5b'],
      aws_secret_access_key: ENV['f4c9c1137bd3191d128bcd53a7fef5bc0d5f7ea7186b62c3b4ecdafd42d19520e11294aadaf6a76a5d53f2b84d0b6d767ac62bd555a9706d04c6f778668a5c5b'],
      region: ENV['S3_REGION']
    }
    config.fog_directory = ENV['S3_BUCKET_NAME']
  end
end

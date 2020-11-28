class BaseUploader < CarrierWave::Uploader::Base
  storage :file

  def store_dir
    "#{model.class.to_s.underscore}/#{model.id}/#{version_name}"
  end

  def extension_whitelist
    %w(jpg jpeg gif png)
  end
end

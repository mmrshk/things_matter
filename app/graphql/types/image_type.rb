# frozen_string_literal: true

module Types::ImageType
  include Types::Base::Interface

  graphql_name 'ImageType'

  I18N_PATH = 'graphql.interfaces.image_type'

  description I18n.t("#{I18N_PATH}.desc")

  field :original_url, String, null: true, description: I18n.t("#{I18N_PATH}.fields.original_url")

  def original_url
    return nil unless object.blob

    Rails.application.routes.url_helpers.rails_blob_url(object.blob)
  end
end

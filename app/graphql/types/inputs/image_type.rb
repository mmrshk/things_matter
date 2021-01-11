# frozen_string_literal: true

module Types
  module Inputs
    class ImageType < ::Types::Base::InputObject
      graphql_name 'ImageInputType'

      description I18n.t('graphql.inputs.image_type.desc')

      argument :id, ID, required: true, description: I18n.t('graphql.inputs.common.fields.id')

      argument :signed_blob_id,
               String,
               required: true,
               description: I18n.t('graphql.inputs.image_type.args.signed_blob_id')
    end
  end
end

# frozen_string_literal: true

module Types
  module Inputs
    class AreaCreateInput < Types::Base::InputObject
      I18N_PATH = 'graphql.inputs.user.area_create_input'

      graphql_name 'AreaCreateInput'

      description I18n.t("#{I18N_PATH}.desc")

      argument :name,
               String,
               required: false,
               description: I18n.t("#{I18N_PATH}.args.name")

      argument :type,
               Types::Enums::AreaTypeEnum,
               required: true,
               description: I18n.t("#{I18N_PATH}.args.type")
    end
  end
end

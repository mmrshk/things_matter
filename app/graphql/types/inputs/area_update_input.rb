# frozen_string_literal: true

module Types
  module Inputs
    class AreaUpdateInput < Types::Base::InputObject
      I18N_PATH = 'graphql.inputs.user.area_update_input'

      graphql_name 'AreaUpdateInput'

      description I18n.t("#{I18N_PATH}.desc")

      argument :id, ID, required: true, description: I18n.t("#{I18N_PATH}.args.id")

      argument :name,
               String,
               required: false,
               description: I18n.t("#{I18N_PATH}.args.name")
    end
  end
end

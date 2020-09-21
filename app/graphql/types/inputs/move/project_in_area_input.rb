# frozen_string_literal: true

module Types
  module Inputs::Move
    class ProjectInAreaInput < Types::Base::InputObject
      I18N_PATH = 'graphql.inputs.move.project_in_area_input'

      graphql_name 'ProjectInAreaInput'

      description I18n.t("#{I18N_PATH}.desc")

      argument :id, ID, required: true, description: I18n.t('graphql.inputs.common.fields.id')

      argument :position,
               Integer,
               required: true,
               description: I18n.t("#{I18N_PATH}.args.position")
    end
  end
end

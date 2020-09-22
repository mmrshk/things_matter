# frozen_string_literal: true

module Types
  module Inputs::Move
    class ProjectWithinAreaInput < Types::Base::InputObject
      I18N_PATH = 'graphql.inputs.move.project_within_area_input'

      graphql_name 'ProjectWithinAreaInput'

      description I18n.t("#{I18N_PATH}.desc")

      argument :id, ID, required: true, description: I18n.t('graphql.inputs.common.fields.id')

      argument :area_id,
               ID,
               required: true,
               description: I18n.t('graphql.inputs.common.fields.id')
    end
  end
end

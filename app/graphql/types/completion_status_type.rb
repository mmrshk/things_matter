# frozen_string_literal: true

module Types
  class CompletionStatusType < Base::Object
    graphql_name 'CompletionStatusType'
    description I18n.t('graphql.types.common.completition_status.desc')

    field :completed,
          Boolean,
          null: false,
          description: I18n.t('graphql.types.common.completition_status.fields.completed')
  end
end

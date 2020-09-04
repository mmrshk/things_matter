# frozen_string_literal: true

module Types
  class NoteType < Base::Object
    I18N_PATH = 'graphql.types.note_type'

    graphql_name 'NoteType'
    description I18n.t("#{I18N_PATH}.desc")

    field :id,
          ID,
          null: false,
          description: I18n.t('graphql.types.common.fields.id')

    field :description,
          String,
          null: true,
          description: I18n.t("#{I18N_PATH}.note_type.fields.description")

    field :name,
          String,
          null: false,
          description: I18n.t("#{I18N_PATH}.note_type.fields.name")

    field :default,
          Boolean,
          null: false,
          description: I18n.t("#{I18N_PATH}.note_type.fields.name")
  end
end

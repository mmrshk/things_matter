# frozen_string_literal: true

module Types
  class NoteTagType < Base::Object
    I18N_PATH = 'graphql.types.note_tag_type'

    graphql_name 'NoteTagType'
    description I18n.t("#{I18N_PATH}.desc")

    field :id,
          ID,
          null: false,
          description: I18n.t('graphql.types.common.fields.id')

    field :name,
          String,
          null: false,
          description: I18n.t("#{I18N_PATH}.fields.name")

    field :note_id,
          ID,
          null: false,
          description: I18n.t("#{I18N_PATH}.note_project_id")
  end
end

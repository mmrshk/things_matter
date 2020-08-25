# frozen_string_literal: true

module Types
  class DeleteListType < Base::Object
    I18N_PATH = 'graphql.types.delete_list_type'

    graphql_name 'DeleteListType'

    description I18n.t("#{I18N_PATH}.desc")

    field :deleted_list_id,
          ID,
          null: false,
          description: I18n.t("#{I18N_PATH}.fields.deleted_list_id")
  end
end

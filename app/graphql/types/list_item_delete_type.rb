# frozen_string_literal: true

module Types
  class ListItemDeleteType < Base::Object
    description I18n.t('graphql.types.list_item_delete_type.desc')

    field :deleted_list_item_id,
          ID,
          null: false,
          description: I18n.t('graphql.types.common.fields.id')
  end
end

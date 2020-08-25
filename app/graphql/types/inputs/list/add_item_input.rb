# frozen_string_literal: true

module Types
  module Inputs
    module List
      class AddItemInput < ::Types::Base::InputObject
        graphql_name 'ListAddItemInput'

        I18N_PATH = 'graphql.inputs.list.add_item_input'

        description I18n.t("#{I18N_PATH}.desc")

        argument :list_id,
                 ID,
                 required: true,
                 description: I18n.t("#{I18N_PATH}.args.list_id")

        argument :movie_id,
                 ID,
                 required: true,
                 description: I18n.t("#{I18N_PATH}.args.movie_id")
      end
    end
  end
end

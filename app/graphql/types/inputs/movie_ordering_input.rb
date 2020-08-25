# frozen_string_literal: true

module Types
  module Inputs
    class MovieOrderingInput < Types::Base::InputObject
      I18N_PATH = 'graphql.inputs.movie_ordering_input'

      graphql_name 'MovieOrderingInput'

      description I18n.t("#{I18N_PATH}.desc")

      argument :sort,
               Types::Enums::MovieSortEnum,
               required: true,
               description: I18n.t("#{I18N_PATH}.args.sort")

      argument :direction,
               Types::Enums::DirectionEnum,
               required: true,
               description: I18n.t("#{I18N_PATH}.args.direction")
    end
  end
end

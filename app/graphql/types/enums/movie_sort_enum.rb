# frozen_string_literal: true

module Types
  module Enums
    class MovieSortEnum < Types::Base::Enum
      I18N_PATH = 'graphql.enums.movie_sort_enum'

      description I18n.t("#{I18N_PATH}.desc")

      value 'TITLE' do
        value 'title'
        description I18n.t("#{I18N_PATH}.values.title")
      end
    end
  end
end

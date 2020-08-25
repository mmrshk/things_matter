# frozen_string_literal: true

module Types
  module Enums
    class DirectionEnum < Types::Base::Enum
      I18N_PATH = 'graphql.enums.direction_enum'

      description I18n.t("#{I18N_PATH}.desc")

      value 'ASC' do
        value 'asc'
        description I18n.t("#{I18N_PATH}.values.asc")
      end

      value 'DESC' do
        value 'desc'
        description I18n.t("#{I18N_PATH}.values.desc")
      end
    end
  end
end

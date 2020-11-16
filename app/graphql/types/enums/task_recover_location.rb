# frozen_string_literal: true

module Types
  module Enums
    class TaskRecoverLocation < Types::Base::Enum
      I18N_PATH = 'graphql.enums.task_recover_location'

      description I18n.t("#{I18N_PATH}.desc")

      value 'TODAY' do
        value 'today'
        description I18n.t("#{I18N_PATH}.values.today")
      end

      value 'ANYTIME' do
        value 'anytime'
        description I18n.t("#{I18N_PATH}.values.anytime")
      end
    end
  end
end

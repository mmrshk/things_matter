# frozen_string_literal: true

module Types
  module Enums
    class TaskFilter < Types::Base::Enum
      I18N_PATH = 'graphql.enums.task_filter'

      description I18n.t("#{I18N_PATH}.desc")

      value 'TODAY' do
        value 'today'
        description I18n.t("#{I18N_PATH}.values.today")
      end

      value 'TRASH' do
        value 'trash'
        description I18n.t("#{I18N_PATH}.values.trash")
      end

      value 'LOGBOOK' do
        value 'logbook'
        description I18n.t("#{I18N_PATH}.values.logbook")
      end

      value 'UPCOMING' do
        value 'upcoming'
        description I18n.t("#{I18N_PATH}.values.upcoming")
      end

      value 'ANYTIME' do
        value 'anytime'
        description I18n.t("#{I18N_PATH}.values.anytime")
      end
    end
  end
end

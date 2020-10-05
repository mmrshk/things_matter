# frozen_string_literal: true

module Types
  module Enums
    class TaskNotePropertySort < Types::Base::Enum
      I18N_PATH = 'graphql.enums.task_note_property_sort'

      description I18n.t("#{I18N_PATH}.desc")

      value 'NAME' do
        value 'name'
        description I18n.t("#{I18N_PATH}.values.name")
      end

      value 'CREATED_AT' do
        value 'created_at'
        description I18n.t("#{I18N_PATH}.values.created_at")
      end

      value 'UPDATED_AT' do
        value 'updated_at'
        description I18n.t("#{I18N_PATH}.values.updated_at")
      end
    end
  end
end

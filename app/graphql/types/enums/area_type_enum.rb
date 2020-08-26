# frozen_string_literal: true

module Types
  module Enums
    class AreaTypeEnum < Types::Base::Enum
      I18N_PATH = 'graphql.enums.area_type_enum'

      description I18n.t("#{I18N_PATH}.desc")

      value 'TASK_AREA' do
        value 'task_area'
        description I18n.t("#{I18N_PATH}.values.task_area")
      end

      value 'NOTE_AREA' do
        value 'note_area'
        description I18n.t("#{I18N_PATH}.values.note_area")
      end
    end
  end
end

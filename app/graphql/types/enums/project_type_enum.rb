# frozen_string_literal: true

module Types
  module Enums
    class ProjectTypeEnum < Types::Base::Enum
      I18N_PATH = 'graphql.enums.project_type_enum'

      description I18n.t("#{I18N_PATH}.desc")

      value 'TASK_PROJECT' do
        value 'task_project'
        description I18n.t("#{I18N_PATH}.values.task_project")
      end

      value 'NOTE_PROJECT' do
        value 'note_project'
        description I18n.t("#{I18N_PATH}.values.note_project")
      end
    end
  end
end

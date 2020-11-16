# frozen_string_literal: true

module Api::V1
  module User::Note
    module Contract
      class Update < Reform::Form
        feature Reform::Form::Dry

        property :name
        property :description
        property :default
        property :note_project_id
        property :user_account_id

        validation do
          configure do
            option :form
            predicates(::CustomPredicates)

            def project_existence?(project_id)
              NoteProject.exists?(id: project_id)
            end
          end

          optional(:name).maybe(:str?)
          optional(:description).maybe(:str?)
          optional(:note_project_id).maybe(:uuid_v4?, :project_existence?)
          optional(:default).maybe(:bool?)
          required(:user_account_id).filled(:uuid_v4?)
        end
      end
    end
  end
end

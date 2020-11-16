# frozen_string_literal: true

module Api::V1
  module User::Note
    module Contract
      class Create < Reform::Form
        feature Reform::Form::Dry

        property :name
        property :description
        property :default
        property :note_project_id
        property :user_account_id

        validation do
          configure do
            predicates(::CustomPredicates)

            def project_existence?(project_id)
              NoteProject.exists?(id: project_id)
            end
          end

          optional(:name).maybe(:str?)
          optional(:description).maybe(:str?)

          required(:default).filled(:bool?)
          required(:note_project_id).filled(:uuid_v4?, :project_existence?)
          required(:user_account_id).filled(:uuid_v4?)
        end
      end
    end
  end
end

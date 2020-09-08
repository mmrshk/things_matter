# frozen_string_literal: true

module Api::V1
  module User::Note
    module Contract
      class Update < Reform::Form
        feature Reform::Form::Dry

        property :name
        property :description
        property :default
        property :project_id

        validation do
          configure do
            option :form
            predicates(::CustomPredicates)

            def project_existence?(project_id)
              Project.exists?(id: project_id)
            end
          end

          optional(:name).maybe(:str?)
          optional(:description).maybe(:str?)
          optional(:project_id).maybe(:uuid_v4?, :project_existence?)
          optional(:default).maybe(:bool?)
        end
      end
    end
  end
end

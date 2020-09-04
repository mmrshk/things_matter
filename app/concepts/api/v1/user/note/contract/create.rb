# frozen_string_literal: true

module Api::V1
  module User::Note
    module Contract
      class Create < Reform::Form
        feature Reform::Form::Dry

        property :name
        property :description
        property :default
        property :project_id

        validation do
          configure do
            predicates(::CustomPredicates)

            def project_existence?(project_id)
              Project.exists?(id: project_id)
            end
          end

          optional(:name).maybe(:str?)
          optional(:description).maybe(:str?)
          required(:default).filled(:bool?)

          required(:project_id).filled(:uuid_v4?, :project_existence?)
        end
      end
    end
  end
end

# frozen_string_literal: true

module Api::V1
  module User::Task
    module Contract
      class Update < Reform::Form
        feature Reform::Form::Dry

        property :name
        property :description
        property :done
        property :deleted
        property :deadline
        property :to_do_day
        property :task_project_id

        validation do
          configure do
            predicates(::CustomPredicates)

            def project_existence?(project_id)
              TaskProject.exists?(id: project_id)
            end

            def valid_date?(day)
              day >= Time.zone.today
            end
          end

          optional(:name).maybe(:str?)
          optional(:description).maybe(:str?)
          optional(:deadline).maybe(:date?, :valid_date?)
          optional(:to_do_day).maybe(:date?, :valid_date?)
          optional(:task_project_id).maybe(:uuid_v4?, :project_existence?)
        end
      end
    end
  end
end

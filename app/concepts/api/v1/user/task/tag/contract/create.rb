# frozen_string_literal: true

module Api::V1
  module User::Task::Tag
    module Contract
      class Create < Reform::Form
        feature Reform::Form::Dry

        property :name
        property :task_id

        validation do
          configure do
            predicates(::CustomPredicates)

            def task_existence?(task_id)
              Task.exists?(id: task_id)
            end
          end

          required(:name).filled(:str?)
          required(:task_id).filled(:uuid_v4?, :task_existence?)
        end
      end
    end
  end
end

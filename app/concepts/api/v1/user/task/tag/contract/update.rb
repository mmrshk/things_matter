# frozen_string_literal: true

module Api::V1
  module User::Task::Tag
    module Contract
      class Update < Reform::Form
        feature Reform::Form::Dry

        property :name
        property :id

        validation do
          configure do
            predicates(::CustomPredicates)

            def task_tag_existence?(id)
              TaskTag.exists?(id: id)
            end
          end

          required(:name).filled(:str?)
          required(:id).filled(:uuid_v4?, :task_tag_existence?)
        end
      end
    end
  end
end

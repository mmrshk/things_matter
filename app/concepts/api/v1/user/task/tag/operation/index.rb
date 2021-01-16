# frozen_string_literal: true

module Api::V1
  module User::Task::Tag
    module Operation
      class Index < Api::V1::ApplicationOperation
        step Model(TaskProject, :find_by), fail_fast: true
        step :set_relation

        def set_relation(ctx, model:, **)
          ctx['result'] = TaskTag.where(task_id: model.tasks.pluck(:id)).select(:name).uniq
        end
      end
    end
  end
end

# frozen_string_literal: true

module Api::V1
  module Move::Task
    module Operation
      class WithinProject < Trailblazer::Operation
        step Model(Task, :find_by), fail_fast: true

        step Macro::Policy(
          policy: TaskPolicy,
          record: ->(ctx) { ctx[:params] },
          rule: :belongs_to_user_account_through_params?
        ), fail_fast: true

        step :update_task!
        step :set_result

        def update_task!(_ctx, model:, params:, **)
          model.update!(task_project_id: params[:task_project_id])
        end

        def set_result(ctx, **)
          ctx['result'] = { completed: true }
        end
      end
    end
  end
end

# frozen_string_literal: true

module Api::V1
  module User::Task::Tag
    module Operation
      class Delete < Trailblazer::Operation
        step Model(TaskTag, :find_by), fail_fast: true

        step Macro::Policy(
          policy: TaskTagPolicy,
          record: ->(ctx) { ctx[:model] },
          rule: :belongs_to_user_account?
        ), fail_fast: true

        step :set_result

        def set_result(ctx, model:, **)
          ctx['result'] = { completed: !!model.destroy }
        end
      end
    end
  end
end

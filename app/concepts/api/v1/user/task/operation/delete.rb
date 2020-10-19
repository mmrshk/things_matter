# frozen_string_literal: true

module Api::V1
  module User::Task
    module Operation
      class Delete < Trailblazer::Operation
        step Model(Task, :find_by), fail_fast: true

        step Macro::Policy(
          policy: TaskPolicy,
          record: ->(ctx) { ctx[:model] },
          rule: :belongs_to_user_account?
        ), fail_fast: true

        step :set_result

        def set_result(ctx, model:, **)
          ctx['result'] = { completed: model.update(deleted: true, deleted_date: Time.zone.today) }
        end
      end
    end
  end
end

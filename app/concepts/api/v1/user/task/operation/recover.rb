# frozen_string_literal: true

module Api::V1::User::Task::Operation
  class Recover < Trailblazer::Operation
    TASK_LOCATION = { anytime: 'anytime', today: 'today' }.freeze

    step Model(Task, :find_by), fail_fast: true

    step Macro::Policy(
      policy: TaskPolicy,
      record: ->(ctx) { ctx[:model] },
      rule: :belongs_to_user_account?
    ), fail_fast: true

    step :recover_task
    pass :set_task_location
    step Macro::Assign(to: 'result', path: %i[model user_account])

    def recover_task(_ctx, model:, **)
      model.update!(deleted: false, deleted_date: nil)
    end

    def set_task_location(_ctx, model:, params:, **)
      return unless params[:task_location]

      if params[:task_location] == TASK_LOCATION[:anytime]
        model.update!(done: false)
      elsif params[:task_location] == TASK_LOCATION[:today]
        model.update!(to_do_day: Time.zone.today)
      end
    end
  end
end

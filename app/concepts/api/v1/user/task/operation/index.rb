# frozen_string_literal: true

module Api::V1::User::Task::Operation
  class Index < Trailblazer::Operation
    TASK_FILTERS = {
      today: { to_do_day: Time.zone.today },
      trash: { deleted: true },
      logbook: { done: true },
      # someday: 'task_project_id IS NULL',
      anytime: { done: false }
    }.freeze

    step :set_result

    def set_result(ctx, filter:, current_user:, **)
      ctx['result'] = filter ? current_user.tasks.where(TASK_FILTERS[filter.intern]) : current_user.tasks
    end
  end
end

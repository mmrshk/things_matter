# frozen_string_literal: true

module Api::V1::User::Task::Operation
  class Index < Trailblazer::Operation
    DAY_TODAY = Time.zone.today
    NEXT_WEEK = Time.zone.today + 1.week
    TASK_FILTERS = {
      today: { to_do_day: DAY_TODAY },
      trash: { deleted: true },
      logbook: { done: true },
      upcoming: { to_do_day: DAY_TODAY..NEXT_WEEK },
      # someday: 'task_project_id IS NULL',
      anytime: { done: false }
    }.freeze

    pass :set_collection
    pass :filter_collection
    pass :sort_collection

    step Macro::Assign(to: 'result', path: %i[collection])

    def set_collection(ctx, current_user:, **)
      ctx[:collection] = current_user.tasks.order(position: :asc)
    end

    def filter_collection(ctx, params:, **)
      ctx[:collection] = ctx[:collection].where(TASK_FILTERS[params[:filter].intern]) if params[:filter]
    end

    def sort_collection(ctx, params:, **)
      ctx[:collection] = ctx[:collection].reorder("#{params[:sort]} #{params[:direction]}") if params[:sort]
    end
  end
end

# frozen_string_literal: true

module Api::V1::User::TaskProject::Operation
  class Index < Trailblazer::Operation
    PROJECT_FILTERS = {
      trash: 'trash',
      logbook: 'logbook',
      anytime: 'anytime'
    }.freeze

    step :projects
    pass :trash_filter
    pass :logbook_filter
    pass :anytime_filter
    step :set_result

    def projects(ctx, current_user:, **)
      ctx[:projects] = current_user.task_projects
    end

    def trash_filter(ctx, filter:, projects:, **)
      return if filter != PROJECT_FILTERS[:trash]

      ctx[:filtered_projects] = projects.select { |project| project.tasks.all?(&:deleted) }
    end

    def logbook_filter(ctx, filter:, projects:, **)
      return if filter != PROJECT_FILTERS[:logbook]

      ctx[:filtered_projects] = projects.select { |project| project.tasks.all?(&:done) }
    end

    def anytime_filter(ctx, filter:, projects:, **)
      return if filter != PROJECT_FILTERS[:anytime]

      ctx[:filtered_projects] = projects.reject { |project| project.tasks.all?(&:done) }
    end

    def set_result(ctx, filter:, current_user:, **)
      ctx['result'] = filter ? ctx[:filtered_projects] : current_user.task_projects
    end
  end
end

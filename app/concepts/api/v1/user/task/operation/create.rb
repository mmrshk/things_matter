# frozen_string_literal: true

module Api::V1
  module User::Task
    module Operation
      class Create < Api::V1::ApplicationOperation
        step Model(Task, :new)

        step Macro::Policy(
          policy: TaskProjectPolicy,
          record: ->(ctx) { ctx[:params][:task_project_id] },
          rule: :belongs_to_user_account_through_params?
        ), fail_fast: true

        step :extract_params
        step Trailblazer::Operation::Contract::Build(constant: ::Api::V1::User::Task::Contract::Create)
        step Trailblazer::Operation::Contract::Validate(), fail_fast: true
        step Trailblazer::Operation::Contract::Persist()

        step Macro::Assign(to: 'result', path: %i[model user_account])

        def extract_params(ctx, current_user:, **)
          ctx[:params] = ctx[:params].merge(user_account_id: current_user.id)
        end
      end
    end
  end
end

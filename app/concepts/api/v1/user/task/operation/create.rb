# frozen_string_literal: true

module Api::V1
  module User::Task
    module Operation
      class Create < Api::V1::ApplicationOperation
        step Model(Task, :new)

        step Macro::Policy(
          policy: ProjectPolicy,
          record: ->(ctx) { ctx[:params][:project_id] },
          rule: :belongs_to_user_account_through_params?
        ), fail_fast: true

        step Trailblazer::Operation::Contract::Build(constant: ::Api::V1::User::Task::Contract::Create)
        step Trailblazer::Operation::Contract::Validate(), fail_fast: true
        step Trailblazer::Operation::Contract::Persist()

        step Macro::Assign(to: 'result', path: %i[model project user_account])
      end
    end
  end
end

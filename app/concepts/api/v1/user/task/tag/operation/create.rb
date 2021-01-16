# frozen_string_literal: true

module Api::V1
  module User::Task::Tag
    module Operation
      class Create < Api::V1::ApplicationOperation
        step Model(TaskTag, :new)

        step Macro::Policy(
          policy: TaskTagPolicy,
          record: ->(ctx) { ctx[:params][:task_id] },
          rule: :belongs_to_user_account_through_params?
        ), fail_fast: true

        step Trailblazer::Operation::Contract::Build(constant: ::Api::V1::User::Task::Tag::Contract::Create)
        step Trailblazer::Operation::Contract::Validate(), fail_fast: true
        step Trailblazer::Operation::Contract::Persist()

        step :set_result

        def set_result(ctx, model:, **)
          ctx['result'] = { completed: model.persisted? }
        end
      end
    end
  end
end

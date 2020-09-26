# frozen_string_literal: true

module Api::V1
  module User::TaskProject
    module Operation
      class Create < Trailblazer::Operation
        step Macro::Policy(policy: ApplicationPolicy, rule: :user_account?), fail_fast: true

        step :init_model, fail_fast: true
        step Trailblazer::Operation::Contract::Build(constant: ::Api::V1::User::TaskProject::Contract::CreateUpdate)
        step Trailblazer::Operation::Contract::Validate(), fail_fast: true
        step Trailblazer::Operation::Contract::Persist()

        step Macro::Assign(to: 'result', path: %i[model user_account])

        def init_model(ctx, current_user:, **)
          ctx[:model] = TaskProject.new(user_account_id: current_user.id)
        end
      end
    end
  end
end

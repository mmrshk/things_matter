# frozen_string_literal: true

module Api::V1
  module User::Area
    module Operation
      class Create < Trailblazer::Operation
        step Macro::Policy(policy: ApplicationPolicy, rule: :user_account?), fail_fast: true

        step :init_model, fail_fast: true
        step Trailblazer::Operation::Contract::Build(constant: ::Api::V1::User::Area::Contract::Create)
        step Trailblazer::Operation::Contract::Validate(), fail_fast: true
        step Trailblazer::Operation::Contract::Persist()

        step Macro::Assign(to: 'result', path: %i[model user_account])

        def init_model(ctx, current_user:, params:, **)
          ctx[:model] = params[:type].camelize.constantize.new(user_account_id: current_user.id)
        end
      end
    end
  end
end

# frozen_string_literal: true

module Api::V1
  module User::Project
    module Operation
      class Update < Trailblazer::Operation
        step Model(Project, :find_by), fail_fast: true

        step Macro::Policy(
          policy: ProjectPolicy,
          record: ->(ctx) { ctx[:model] },
          rule: :belongs_to_user_account?
        ), fail_fast: true

        step :extract_params
        step Trailblazer::Operation::Contract::Build(constant: ::Api::V1::User::Project::Contract::CreateUpdate)
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

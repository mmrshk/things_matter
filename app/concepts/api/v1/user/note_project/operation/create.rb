# frozen_string_literal: true

module Api::V1
  module User::NoteProject
    module Operation
      class Create < Trailblazer::Operation
        step Macro::Policy(policy: ApplicationPolicy, rule: :user_account?), fail_fast: true

        step :init_model, fail_fast: true
        step Trailblazer::Operation::Contract::Build(constant: ::Api::V1::User::NoteProject::Contract::CreateUpdate)
        step Trailblazer::Operation::Contract::Validate(), fail_fast: true
        step Trailblazer::Operation::Contract::Persist()

        step Macro::Assign(to: 'result', path: %i[model user_account])

        def init_model(ctx, current_user:, **)
          ctx[:model] = NoteProject.new(user_account_id: current_user.id)
        end
      end
    end
  end
end

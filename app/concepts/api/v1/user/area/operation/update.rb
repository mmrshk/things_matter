# frozen_string_literal: true

module Api::V1
  module User::Area
    module Operation
      class Update < Trailblazer::Operation
        step Model(Area, :find_by), fail_fast: true

        step Macro::Policy(
          policy: AreaPolicy,
          record: ->(ctx) { ctx[:model] },
          rule: :belongs_to_user_account?
        ), fail_fast: true

        step Trailblazer::Operation::Contract::Build(constant: ::Api::V1::User::Area::Contract::CreateUpdate)
        step Trailblazer::Operation::Contract::Validate(), fail_fast: true
        step Trailblazer::Operation::Contract::Persist()

        step Macro::Assign(to: 'result', path: %i[model user_account])
      end
    end
  end
end

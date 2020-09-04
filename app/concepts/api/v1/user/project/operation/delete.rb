# frozen_string_literal: true

module Api::V1
  module User::Project
    module Operation
      class Delete < Trailblazer::Operation
        step Model(Project, :find_by), fail_fast: true

        step Macro::Policy(
          policy: ProjectPolicy,
          record: ->(ctx) { ctx[:model] },
          rule: :belongs_to_user_account?
        ), fail_fast: true

        step :set_result

        def set_result(ctx, model:, **)
          ctx['result'] = { completed: !!model.destroy } # rubocop:disable Style/DoubleNegation
        end
      end
    end
  end
end

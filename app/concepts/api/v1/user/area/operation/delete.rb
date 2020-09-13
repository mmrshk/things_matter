# frozen_string_literal: true

module Api::V1
  module User::Area
    module Operation
      class Delete < Trailblazer::Operation
        step :set_model
        fail Macro::Semantic(failure: :not_found), fail_fast: true

        step Macro::Policy(
          policy: AreaPolicy,
          record: ->(ctx) { ctx[:model] },
          rule: :belongs_to_user_account?
        ), fail_fast: true

        step :set_result

        def set_model(ctx, params:, **)
          ctx[:model] = TaskArea.find_by(id: params[:id]) || NoteArea.find_by(id: params[:id])
        end

        def set_result(ctx, model:, **)
          ctx['result'] = { completed: !!model.destroy } # rubocop:disable Style/DoubleNegation
        end
      end
    end
  end
end

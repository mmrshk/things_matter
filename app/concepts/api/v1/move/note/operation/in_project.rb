# frozen_string_literal: true

module Api::V1
  module Move::Note
    module Operation
      class InProject < Trailblazer::Operation
        step Model(Note, :find_by), fail_fast: true

        step Macro::Policy(
          policy: NotePolicy,
          record: ->(ctx) { ctx[:model] },
          rule: :belongs_to_user_account?
        ), fail_fast: true

        step :update_position!
        step :set_result

        def update_position!(_ctx, model:, params:, **)
          model.update!(position: params[:position])
        end

        def set_result(ctx, **)
          ctx['result'] = { completed: true }
        end
      end
    end
  end
end

# frozen_string_literal: true

module Api::V1
  module Move::Note
    module Operation
      class WithinProject < Trailblazer::Operation
        step Model(Note, :find_by), fail_fast: true

        step Macro::Policy(
          policy: NotePolicy,
          record: ->(ctx) { ctx[:params] },
          rule: :belongs_to_user_account_through_params?
        ), fail_fast: true

        step :update_note!
        step :set_result

        def update_note!(_ctx, model:, params:, **)
          model.update!(note_project_id: params[:note_project_id])
        end

        def set_result(ctx, **)
          ctx['result'] = { completed: true }
        end
      end
    end
  end
end

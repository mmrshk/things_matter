# frozen_string_literal: true

module Api::V1::User::Note::Operation
  class Recover < Trailblazer::Operation
    step Model(Note, :find_by), fail_fast: true

    step Macro::Policy(
      policy: NotePolicy,
      record: ->(ctx) { ctx[:model] },
      rule: :belongs_to_user_account?
    ), fail_fast: true

    pass :recover_note
    step Macro::Assign(to: 'result', path: %i[model user_account])

    def recover_note(_ctx, model:, params:, **)
      return model.update!(deleted: false, deleted_date: nil) unless params[:note_project_id]

      model.update!(deleted: false, deleted_date: nil, note_project_id: params[:note_project_id])
    end
  end
end

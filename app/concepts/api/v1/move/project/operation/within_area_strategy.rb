# frozen_string_literal: true

module Api::V1
  module Move::Project
    module Operation
      class WithinAreaStrategy < Trailblazer::Operation
        step :set_model, fail_fast: true
        step Nested(:strategy)
        step :set_result

        def set_model(ctx, params:, **)
          ctx[:model] = NoteProject.find_by(id: params[:id]) || TaskProject.find_by(id: params[:id])
        end

        def strategy(_ctx, model:, **)
          return Api::V1::Move::Project::Operation::WithinNoteArea if model.is_a?(NoteProject)

          Api::V1::Move::Project::Operation::WithinTaskArea
        end

        def set_result(ctx, **)
          ctx['result'] = { completed: true }
        end
      end
    end
  end
end

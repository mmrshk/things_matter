# frozen_string_literal: true

module Api::V1
  module Move::Project
    module Operation
      class InArea < Trailblazer::Operation
        step :set_model, fail_fast: true

        step Macro::Policy(
          policy: ProjectPolicy,
          record: ->(ctx) { ctx[:model] },
          rule: :belongs_to_user_account?
        ), fail_fast: true

        step :update_position!
        step :set_result

        def set_model(ctx, params:, **)
          ctx[:model] = NoteProject.find_by(id: params[:id]) || TaskProject.find_by(id: params[:id])
        end

        def update_position!(ctx, model:, params:, **)
          model.update!(position: params[:position])
        end

        def set_result(ctx, **)
          ctx['result'] = { completed: true }
        end
      end
    end
  end
end

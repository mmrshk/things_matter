# frozen_string_literal: true

module Api::V1
  module Move::Area
    module Operation
      class WithinArea < Trailblazer::Operation
        step :set_model, fail_fast: true

        step Macro::Policy(
          policy: AreaPolicy,
          record: ->(ctx) { ctx[:model] },
          rule: :belongs_to_user_account?
        ), fail_fast: true

        step :update_position!
        step :set_result

        def set_model(ctx, params:, **)
          ctx[:model] = NoteArea.find_by(id: params[:id]) || TaskArea.find_by(id: params[:id])
        end

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

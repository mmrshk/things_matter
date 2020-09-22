# frozen_string_literal: true

module Api::V1
  module Move::Project
    module Operation
      class WithinTaskArea < Trailblazer::Operation
        step Macro::Policy(
          policy: TaskProjectPolicy,
          record: ->(ctx) { ctx[:params] },
          rule: :area_and_project_belongs_to_user_account_through_params?
        ), fail_fast: true

        step :update_position!

        def update_position!(_ctx, model:, params:, **)
          model.update!(position: params[:position], task_area_id: params[:area_id])
        end
      end
    end
  end
end

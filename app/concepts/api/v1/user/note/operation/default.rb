# frozen_string_literal: true

module Api::V1
  module User::Note
    module Operation
      class Default < Api::V1::ApplicationOperation
        step Model(Note, :find_by), fail_fast: true

        step Macro::Policy(
          policy: NotePolicy,
          record: ->(ctx) { ctx[:model] },
          rule: :belongs_to_user_account?
        ), fail_fast: true

        step Macro::Assign(to: :params, value: { default: true } )

        step Wrap(Shared::Steps::ActiveRecordTransaction) {
          step Rescue(ActiveRecord::ActiveRecordError, handler: :raise_error_handler) {
            step ::Shared::Steps::UpdateDefaultNote

            step :update_note!
          }
        }

        step :set_result

        def update_note!(ctx, model:, **)
          model.update!(default: true)
        end

        def set_result(ctx, **)
          ctx['result'] = { completed: true }
        end
      end
    end
  end
end

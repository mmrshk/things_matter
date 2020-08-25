# frozen_string_literal: true

module User::List
  module Operation
    class Delete < Trailblazer::Operation
      step Model(List, :find_by), fail_fast: true

      step Policy::Guard(User::List::Guard::AddDelete.new), fail_fast: true

      step Rescue(ActiveRecord::ActiveRecordError, handler: :destroy_failure_handler) {
        step :destroy!
      }, fail_fast: true

      step :set_result

      def destroy!(ctx, **)
        ctx[:model].destroy!
      end

      def set_result(ctx, **)
        ctx['result'] = { deleted_list_id: ctx[:model].id }
      end

      private

      def destroy_failure_handler(ctx, exception)
        ctx['operation_status'] = :execution_error
        ctx['operation_message'] = exception.message
      end
    end
  end
end

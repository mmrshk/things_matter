# frozen_string_literal: true

module Api::V1
  class ApplicationOperation < Trailblazer::Operation
    private

    def raise_error_handler(exception, ctx)
      ctx['operation_status'] = :execution_error
      ctx['operation_message'] = exception.message

      raise ActiveRecord::Rollback, exception.message
    end
  end
end

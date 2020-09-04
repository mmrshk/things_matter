# frozen_string_literal: true

module Shared
  module Steps
    class UpdateDefaultNote < Api::V1::ApplicationOperation
      step :update_note

      def update_note(ctx, params:, **)
        return unless params[:default]

        default_note = Note.find_by(default: true)

        default_note&.update!(default: false)
      end
    end
  end
end

# frozen_string_literal: true

module Move
  module Note
    WithinProject = Dry::Validation.Schema do
      input :hash?

      required(:data).schema do
        required(:moveNoteWithinProject).schema do
          required(:completed).filled(:bool?)
        end
      end
    end
  end
end

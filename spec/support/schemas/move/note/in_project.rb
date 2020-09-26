# frozen_string_literal: true

module Move
  module Note
    InProject = Dry::Validation.Schema do
      input :hash?

      required(:data).schema do
        required(:moveNoteInProject).schema do
          required(:completed).filled(:bool?)
        end
      end
    end
  end
end

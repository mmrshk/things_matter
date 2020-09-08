# frozen_string_literal: true

module UserNote
  DeleteSchema = Dry::Validation.Schema do
    input :hash?

    required(:data).schema do
      required(:userNoteDelete).schema do
        required(:completed).filled(:bool?)
      end
    end
  end
end

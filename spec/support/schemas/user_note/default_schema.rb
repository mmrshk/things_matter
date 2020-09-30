# frozen_string_literal: true

module UserNote
  DefaultSchema = Dry::Validation.Schema do
    input :hash?

    required(:data).schema do
      required(:userNoteDefault).schema do
        required(:completed).filled(:bool?)
      end
    end
  end
end

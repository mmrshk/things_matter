# frozen_string_literal: true

module UserNoteTag
  DeleteSchema = Dry::Validation.Schema do
    input :hash?

    required(:data).schema do
      required(:userNoteTagDelete).schema do
        required(:completed).filled(:bool?)
      end
    end
  end
end

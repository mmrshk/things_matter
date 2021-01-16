# frozen_string_literal: true

module UserNoteTag
  CreateSchema = Dry::Validation.Schema do
    input :hash?

    required(:data).schema do
      required(:userNoteTagCreate).schema do
        required(:completed).filled(:bool?)
      end
    end
  end
end

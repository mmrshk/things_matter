# frozen_string_literal: true

module UserNoteTag
  UpdateSchema = Dry::Validation.Schema do
    input :hash?

    required(:data).schema do
      required(:userNoteTagUpdate).schema do
        required(:completed).filled(:bool?)
      end
    end
  end
end

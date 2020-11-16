# frozen_string_literal: true

module UserNote
  RecoverSchema = Dry::Validation.Schema do
    input :hash?

    required(:data).schema do
      required(:userNoteRecover).schema do
        required(:id).filled(:str?)
      end
    end
  end
end

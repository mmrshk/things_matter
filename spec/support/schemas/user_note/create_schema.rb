# frozen_string_literal: true

module UserNote
  CreateSchema = Dry::Validation.Schema do
    input :hash?

    required(:data).schema do
      required(:userNoteCreate).schema do
        required(:noteProjects).each do
          required(:name).filled(:str?)

          required(:notes).each do
            required(:id).filled(:str?)
            required(:name).filled(:str?)
            required(:description).filled(:str?)
            required(:default).filled(:bool?)
          end
        end
      end
    end
  end
end

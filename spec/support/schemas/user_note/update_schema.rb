# frozen_string_literal: true

module UserNote
  UpdateSchema = Dry::Validation.Schema do
    input :hash?

    required(:data).schema do
      required(:userNoteUpdate).schema do
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

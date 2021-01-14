# frozen_string_literal: true

module UserTaskTag
  DeleteSchema = Dry::Validation.Schema do
    input :hash?

    required(:data).schema do
      required(:userTaskTagDelete).schema do
        required(:completed).filled(:bool?)
      end
    end
  end
end

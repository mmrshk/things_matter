# frozen_string_literal: true

module UserTaskTag
  CreateSchema = Dry::Validation.Schema do
    input :hash?

    required(:data).schema do
      required(:userTaskTagCreate).schema do
        required(:completed).filled(:bool?)
      end
    end
  end
end

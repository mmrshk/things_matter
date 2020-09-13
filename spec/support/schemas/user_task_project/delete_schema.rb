# frozen_string_literal: true

module UserTaskProject
  DeleteSchema = Dry::Validation.Schema do
    input :hash?

    required(:data).schema do
      required(:userTaskProjectDelete).schema do
        required(:completed).filled(:bool?)
      end
    end
  end
end

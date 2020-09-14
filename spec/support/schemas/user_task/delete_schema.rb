# frozen_string_literal: true

module UserTask
  DeleteSchema = Dry::Validation.Schema do
    input :hash?

    required(:data).schema do
      required(:userTaskDelete).schema do
        required(:completed).filled(:bool?)
      end
    end
  end
end

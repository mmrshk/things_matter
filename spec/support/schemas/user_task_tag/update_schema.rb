# frozen_string_literal: true

module UserTaskTag
  UpdateSchema = Dry::Validation.Schema do
    input :hash?

    required(:data).schema do
      required(:userTaskTagUpdate).schema do
        required(:completed).filled(:bool?)
      end
    end
  end
end

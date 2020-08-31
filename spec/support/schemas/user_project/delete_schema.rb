# frozen_string_literal: true

module UserProject
  DeleteSchema = Dry::Validation.Schema do
    input :hash?

    required(:data).schema do
      required(:userProjectDelete).schema do
        required(:completed).filled(:bool?)
      end
    end
  end
end

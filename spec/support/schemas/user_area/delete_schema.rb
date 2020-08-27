# frozen_string_literal: true

module UserArea
  DeleteSchema = Dry::Validation.Schema do
    input :hash?

    required(:data).schema do
      required(:userAreaDelete).schema do
        required(:completed).filled(:bool?)
      end
    end
  end
end

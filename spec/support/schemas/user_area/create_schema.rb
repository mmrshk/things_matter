# frozen_string_literal: true

module UserArea
  CreateSchema = Dry::Validation.Schema do
    input :hash?

    required(:data).schema do
      required(:userAreaCreate).schema do
        required(:email).filled(:str?)
        required(:taskAreas).each do
          required(:name).filled(:str?)
          required(:type).filled(:str?)
        end
      end
    end
  end
end

# frozen_string_literal: true

module Schemas
  module Shared
    TaskSchema = Dry::Validation.Schema do
      input :hash?

      schema do
        required(:id).filled(:str?)
        required(:name).filled(:str?)
        required(:description).filled(:str?)
        required(:deadline).filled(:str?)
        required(:toDoDay).filled(:str?)
        required(:deleted).filled(:bool?)
        required(:done).filled(:bool?)
      end
    end
  end
end

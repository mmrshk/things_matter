# frozen_string_literal: true

module UserTask
  CreateSchema = Dry::Validation.Schema do
    input :hash?

    required(:data).schema do
      required(:userTaskCreate).schema do
        required(:taskProjects).each do
          required(:tasks).each do
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
  end
end

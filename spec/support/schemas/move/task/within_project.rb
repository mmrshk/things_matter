# frozen_string_literal: true

module Move
  module Task
    WithinProject = Dry::Validation.Schema do
      input :hash?

      required(:data).schema do
        required(:moveTaskWithinProject).schema do
          required(:completed).filled(:bool?)
        end
      end
    end
  end
end

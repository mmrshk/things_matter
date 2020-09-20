# frozen_string_literal: true

module Move
  module Task
    InProject = Dry::Validation.Schema do
      input :hash?

      required(:data).schema do
        required(:moveTaskInProject).schema do
          required(:completed).filled(:bool?)
        end
      end
    end
  end
end

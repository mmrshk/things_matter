# frozen_string_literal: true

module Move
  module Project
    WithinArea = Dry::Validation.Schema do
      input :hash?

      required(:data).schema do
        required(:moveProjectWithinArea).schema do
          required(:completed).filled(:bool?)
        end
      end
    end
  end
end

# frozen_string_literal: true

module Move
  module Project
    InArea = Dry::Validation.Schema do
      input :hash?

      required(:data).schema do
        required(:moveProjectInArea).schema do
          required(:completed).filled(:bool?)
        end
      end
    end
  end
end

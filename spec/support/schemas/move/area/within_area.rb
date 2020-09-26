# frozen_string_literal: true

module Move
  module Area
    WithinArea = Dry::Validation.Schema do
      input :hash?

      required(:data).schema do
        required(:moveAreaWithinAreas).schema do
          required(:completed).filled(:bool?)
        end
      end
    end
  end
end

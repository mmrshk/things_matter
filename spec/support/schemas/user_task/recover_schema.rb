# frozen_string_literal: true

module UserTask
  RecoverSchema = Dry::Validation.Schema do
    input :hash?

    required(:data).schema do
      required(:userTaskRecover).schema do
        required(:id).filled(:str?)
      end
    end
  end
end

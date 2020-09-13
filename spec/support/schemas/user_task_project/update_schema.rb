# frozen_string_literal: true

module UserTaskProject
  UpdateSchema = Dry::Validation.Schema do
    input :hash?

    required(:data).schema do
      required(:userTaskProjectUpdate).schema do
        required(:email).filled(:str?)
        required(:taskProjects).each do
          required(:name).filled(:str?)
          required(:deadline).filled(:str?)
        end
      end
    end
  end
end

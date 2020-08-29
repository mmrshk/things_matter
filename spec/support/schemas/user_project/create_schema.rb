# frozen_string_literal: true

module UserProject
  CreateSchema = Dry::Validation.Schema do
    input :hash?

    required(:data).schema do
      required(:userProjectCreate).schema do
        required(:email).filled(:str?)
        required(:taskProjects).each do
          required(:name).filled(:str?)
          required(:deadline).filled(:str?)
          required(:type).filled(
            included_in?: [TaskProject.to_s, NoteProject.to_s]
          )
        end
      end
    end
  end
end
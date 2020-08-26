# frozen_string_literal: true

ExecutionErrorSchema = Dry::Validation.Schema do
  input :hash?

  required(:data).value(:empty?)
  required(:errors).each do
    schema do
      required(:message).value(:str?)
      required(:extensions).schema do
        required(:code).value(eql?: Constants::EXECUTION_ERROR)
      end
      optional(:locations).value(type?: Array).each(:hash?)
      optional(:path).value(type?: Array).each(:str?)
    end
  end
end

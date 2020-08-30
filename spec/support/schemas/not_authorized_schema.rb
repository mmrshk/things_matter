# frozen_string_literal: true

NotAuthorizedSchema = Dry::Validation.Schema do
  input :hash?

  required(:data).maybe do
    schema do
      optional(:company).value(:empty?)
    end
  end
  required(:errors).each do
    schema do
      required(:message).value(eql?: I18n.t('graphql.errors.messages.not_authorized'))
      optional(:locations).value(type?: Array).each(:hash?)
      optional(:extensions).value(type?: Array).each(:hash?)
      required(:extensions).schema do
        optional(:code).value(eql?: 'UNAUTHORIZED')
        optional(:problems).each do
          schema do
            required(:path).value(type?: Array)
            required(:explanation).filled(:str?)
          end
        end
      end
      optional(:path).value(type?: Array).each(:str?)
    end
  end
end

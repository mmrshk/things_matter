# frozen_string_literal: true

module User::List
  module Contract
    class Create < Reform::Form
      feature Reform::Form::Dry

      property :name
      property :description

      validation :default do
        configure do
          option :form

          def list_exists?
            !List.exists?(user_account_id: form.model.user_account_id, name: form.name)
          end
        end

        required(:name).filled(:str?, :list_exists?, max_size?: Constants::STRING_MAX_LENGTH)
        optional(:description).maybe(:str?, max_size?: Constants::TEXT_MAX_LENGTH)
      end
    end
  end
end

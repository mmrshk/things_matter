# frozen_string_literal: true

module Api::V1
  module User::Area
    module Contract
      class Create < Reform::Form
        feature Reform::Form::Dry

        property :name

        validation do
          optional(:name).maybe(:str?)
        end
      end
    end
  end
end

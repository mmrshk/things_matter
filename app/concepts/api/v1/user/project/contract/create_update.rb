# frozen_string_literal: true

module Api::V1
  module User::Project
    module Contract
      class CreateUpdate < Reform::Form
        feature Reform::Form::Dry

        property :name
        property :deadline
        property :area_id, empty: true
        property :user_account_id

        validation do
          configure do
            predicates(::CustomPredicates)

            def area_existence?(area_id)
              Area.exists?(id: area_id)
            end

            def valid_deadline?(deadline)
              deadline >= Date.today
            end
          end

          required(:user_account_id).filled(:uuid_v4?)

          optional(:area_id).maybe(:uuid_v4?, :area_existence?)
          optional(:name).maybe(:str?)
          optional(:deadline).maybe(:valid_deadline?, :date?)

          validate(
            area_belongs_to_user?: %i[area_id user_account_id]
          ) do |area_id, user_account_id|
            next true unless area_id

            area = Area.find_by(id: area_id)

            area.user_account_id == user_account_id
          end
        end
      end
    end
  end
end

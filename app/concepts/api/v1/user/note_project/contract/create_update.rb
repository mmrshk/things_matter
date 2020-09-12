# frozen_string_literal: true

module Api::V1
  module User::NoteProject
    module Contract
      class CreateUpdate < Reform::Form
        feature Reform::Form::Dry

        property :name
        property :deadline
        property :note_area_id, empty: true
        property :user_account_id

        validation do
          configure do
            predicates(::CustomPredicates)

            def area_existence?(area_id)
              NoteArea.exists?(id: area_id)
            end

            def valid_deadline?(deadline)
              deadline >= Date.today
            end
          end

          required(:user_account_id).filled(:uuid_v4?)

          optional(:note_area_id).maybe(:uuid_v4?, :area_existence?)
          optional(:name).maybe(:str?)
          optional(:deadline).maybe(:valid_deadline?, :date?)

          validate(
            area_belongs_to_user?: %i[area_id user_account_id]
          ) do |note_area_id, user_account_id|
            next true unless note_area_id

            note_area = NoteArea.find_by(id: note_area_id)

            note_area.user_account_id == user_account_id
          end
        end
      end
    end
  end
end

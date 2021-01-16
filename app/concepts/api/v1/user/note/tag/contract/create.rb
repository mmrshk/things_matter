# frozen_string_literal: true

module Api::V1
  module User::Note::Tag
    module Contract
      class Create < Reform::Form
        feature Reform::Form::Dry

        property :name
        property :note_id

        validation do
          configure do
            predicates(::CustomPredicates)

            def note_existence?(note_id)
              Note.exists?(id: note_id)
            end
          end

          required(:name).filled(:str?)
          required(:note_id).filled(:uuid_v4?, :note_existence?)
        end
      end
    end
  end
end

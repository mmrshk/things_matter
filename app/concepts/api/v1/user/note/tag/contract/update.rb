# frozen_string_literal: true

module Api::V1
  module User::Note::Tag
    module Contract
      class Update < Reform::Form
        feature Reform::Form::Dry

        property :name
        property :id

        validation do
          configure do
            predicates(::CustomPredicates)

            def note_tag_existence?(id)
              NoteTag.exists?(id: id)
            end
          end

          required(:name).filled(:str?)
          required(:id).filled(:uuid_v4?, :note_tag_existence?)
        end
      end
    end
  end
end

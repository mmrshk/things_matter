# frozen_string_literal: true

module Api::V1
  module User::Note
    module Contract
      class Create < Reform::Form
        feature Reform::Form::Dry

        property :name
        property :description
        property :default
        property :note_project_id
        property :user_account_id

        collection :note_images, populator: :populate_note_images! do
          property :id
          property :signed_blob_id, virtual: true
        end

        validation do
          configure do
            predicates(::CustomPredicates)

            def project_existence?(project_id)
              NoteProject.exists?(id: project_id)
            end
          end

          optional(:product_images).each do
            schema do
              required(:id).filled(:uuid_v4?)
              required(:signed_blob_id).maybe(:str?, :signed_blob_id?)
            end
          end

          optional(:name).maybe(:str?)
          optional(:description).maybe(:str?)

          required(:default).filled(:bool?)
          required(:note_project_id).filled(:uuid_v4?, :project_existence?)
          required(:user_account_id).filled(:uuid_v4?)
        end

        def populate_note_images!(fragment:, index:, **)
          note_image = init_note_image(fragment, index)
          note_images.append(note_image)
        end

        def init_note_image(fragment, _index)
          note_image = NoteImage.new(
            id: fragment[:id],
            note: model
          )

          note_image.file.attach(fragment[:signed_blob_id])

          note_image
        end
      end
    end
  end
end

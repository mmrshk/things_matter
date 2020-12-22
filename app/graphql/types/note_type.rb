# frozen_string_literal: true

module Types
  class NoteType < Base::Object
    I18N_PATH = 'graphql.types.note_type'

    graphql_name 'NoteType'
    description I18n.t("#{I18N_PATH}.desc")

    field :id,
          ID,
          null: false,
          description: I18n.t('graphql.types.common.fields.id')

    field :description,
          String,
          null: true,
          description: I18n.t("#{I18N_PATH}.fields.description")

    field :name,
          String,
          null: false,
          description: I18n.t("#{I18N_PATH}.fields.name")

    field :default,
          Boolean,
          null: false,
          description: I18n.t("#{I18N_PATH}.fields.name")

    field :note_images,
          [Types::ImageType],
          null: true,
          description: I18n.t("#{I18N_PATH}.note_images")

    def images
      BatchLoader::GraphQL.for(object.id).batch(default_value: []) do |task_ids, loader|
        ::NoteImage
          .with_attached_file
          .where(note_id: note_ids)
          .each do |note_image|
            loader.call(note_image.movie_id) { |memo| memo << note_image.file }
          end
      end
    end
  end
end

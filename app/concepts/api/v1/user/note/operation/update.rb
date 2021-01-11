# frozen_string_literal: true

module Api::V1
  module User::Note
    module Operation
      class Update < Trailblazer::Operation
        step Model(Note, :find_by), fail_fast: true

        step Macro::Policy(
          policy: NotePolicy,
          record: ->(ctx) { ctx[:model] },
          rule: :belongs_to_user_account?
        ), fail_fast: true

        step :extract_params
        step Trailblazer::Operation::Contract::Build(constant: ::Api::V1::User::Note::Contract::Update)

        step Wrap(Shared::Steps::ActiveRecordTransaction) {
          step Rescue(ActiveRecord::ActiveRecordError, handler: :raise_error_handler) {
            pass :exist_images
            pass :delete_images
            pass :extract_images_params

            step Trailblazer::Operation::Contract::Validate(), fail_fast: true
            step Trailblazer::Operation::Contract::Persist()
          }, fail_fast: true
        }

        step Macro::Assign(to: 'result', path: %i[model user_account])

        def extract_params(ctx, current_user:, **)
          ctx[:params] = ctx[:params].merge(user_account_id: current_user.id)
        end

        def exist_images(ctx, params:, model:, **)
          return unless params[:note_images]

          ctx[:exist_images] = NoteImage.where(id: params[:note_images].pluck(:id), note_id: model.id)
        end

        def delete_images(ctx, params:, model:, **)
          return unless params[:note_images]

          images_to_delete = NoteImage.where(note_id: model.id) - ctx[:exist_images]
          images_to_delete.each(&:destroy!)
        end

        def extract_images_params(ctx, params:, **)
          return unless params[:note_images]

          ctx[:params][:note_images] = ctx[:params][:note_images].reject do |param|
            param[:id].in?(ctx[:exist_images].pluck(:id))
          end
        end
      end
    end
  end
end

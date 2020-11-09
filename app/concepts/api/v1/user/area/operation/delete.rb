# frozen_string_literal: true

module Api::V1
  module User::Area
    module Operation
      class Delete < Trailblazer::Operation
        step :set_model
        fail Macro::Semantic(failure: :not_found), fail_fast: true

        step Macro::Policy(
          policy: AreaPolicy,
          record: ->(ctx) { ctx[:model] },
          rule: :belongs_to_user_account?
        ), fail_fast: true

        step Wrap(Shared::Steps::ActiveRecordTransaction) {
          step Rescue(ActiveRecord::ActiveRecordError, handler: :raise_error_handler) {
            pass :update_note_area_relationships
            pass :update_task_area_relationships

            step :set_result
          }
        }

        def set_model(ctx, params:, **)
          ctx[:model] = TaskArea.find_by(id: params[:id]) || NoteArea.find_by(id: params[:id])
        end

        def update_note_area_relationships(ctx, model:, **)
          return if model.is_a?(TaskArea)

          model.note_projects.each do |project|
            project.update!(deleted: true, deleted_date: Time.zone.today)

            project.notes.each do |note|
              note.update!(deleted: true, deleted_date: Time.zone.today)
            end
          end
        end

        def update_task_area_relationships(ctx, model:, **)
          return if model.is_a?(NoteArea)

          model.task_projects.each do |project|
            project.update!(deleted: true, deleted_date: Time.zone.today)

            project.tasks.each do |task|
              task.update!(deleted: true, deleted_date: Time.zone.today)
            end
          end
        end

        def set_result(ctx, model:, **)
          ctx['result'] = { completed: model.update!(deleted: true, deleted_date: Time.zone.today) }
        end
      end
    end
  end
end

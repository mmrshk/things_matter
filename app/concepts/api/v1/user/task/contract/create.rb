# frozen_string_literal: true

module Api::V1
  module User::Task
    module Contract
      class Create < Reform::Form
        feature Reform::Form::Dry

        property :name
        property :description
        property :done
        property :deleted
        property :deadline
        property :to_do_day
        property :task_project_id
        property :user_account_id

        collection :task_images, populator: :populate_task_images! do
          property :id
          property :signed_blob_id, virtual: true
        end

        validation do
          configure do
            predicates(::CustomPredicates)

            def project_existence?(project_id)
              TaskProject.exists?(id: project_id)
            end

            def valid_date?(day)
              day >= Time.zone.today
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

          optional(:deadline).maybe(:date?, :valid_date?)
          optional(:to_do_day).maybe(:date?, :valid_date?)

          required(:task_project_id).filled(:uuid_v4?, :project_existence?)
          required(:user_account_id).filled(:uuid_v4?)
        end

        def populate_task_images!(fragment:, index:, **)
          task_image = init_task_image(fragment, index)
          task_images.append(task_image)
        end

        def init_task_image(fragment, index)
          task_image = TaskImage.new(
            id: fragment[:id],
            task: model
          )

          task_image.file.attach(fragment[:signed_blob_id])

          task_image
        end
      end
    end
  end
end

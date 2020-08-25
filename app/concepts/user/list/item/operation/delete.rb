# frozen_string_literal: true

module User::List
  module Item::Operation
    class Delete < Trailblazer::Operation
      step :model
      fail :not_found, fail_fast: true

      step Policy::Guard(User::List::Guard::AddDelete.new), fail_fast: true

      step Rescue(ActiveRecord::RecordNotDestroyed, ActiveRecord::RecordInvalid, handler: :destroy_error_handler) {
        step :destroy_list_item!
      }, fail_fast: true

      step :result

      def model(ctx, params:, **)
        ctx[:model] = ListsMovie.find_by(list_id: params[:list_id], movie_id: params[:movie_id])
      end

      def destroy_list_item!(_ctx, model:, **)
        model.destroy!
      end

      def result(ctx, **)
        ctx['result'] = { deleted_list_item_id: ctx[:model].movie_id }
      end

      private

      def destroy_error_handler(_exception, ctx)
        ctx['operation_status'] = :execution_error
      end

      def not_found(ctx, params:, **)
        ctx['operation_status'] = :not_found
        ctx['operation_message'] = I18n.t('operations.product.delete.errors.not_found', id: params[:id])
      end
    end
  end
end

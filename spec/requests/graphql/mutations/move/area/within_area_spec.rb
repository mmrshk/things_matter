# frozen_string_literal: true

describe 'mutation moveProjectInTask', type: :request do
  let_it_be(:current_user) { create(:user_account, with_task_areas: true, task_areas_count: 4) }

  let(:first_area) { current_user.task_areas.find_by(position: 1) }
  let(:second_area) { current_user.task_areas.find_by(position: 2) }
  let(:third_area) { current_user.task_areas.find_by(position: 3) }
  let(:fourth_area) { current_user.task_areas.find_by(position: 4) }

  let(:token) { generate_token(account_id: current_user.id) }

  let(:variables) do
    {
      input: {
        id: first_area.id,
        position: 4
      }
    }
  end

  context 'when success' do
    it 'returns success result' do
      authorized_graphql_post(
        query: move_area_within_areas_mutation,
        variables: variables,
        auth_token: token
      )

      expect(response).to match_schema(Move::Area::WithinArea)
      expect(response.status).to be(200)
    end
  end

  context 'when failed' do
    context 'when passed strange id' do
      let(:variables) { { input: { id: SecureRandom.uuid } } }

      it 'returns execution error data' do
        authorized_graphql_post(
          query: move_area_within_areas_mutation,
          variables: variables,
          auth_token: token
        )

        expect(response).to match_schema(ErrorSchema)
        expect(response.status).to be(200)
      end
    end

    context 'when raise ActiveRecord::ActiveRecordError' do
      before { allow_any_instance_of(TaskArea).to receive(:update!).and_raise(ActiveRecord::ActiveRecordError) }

      it 'returns execution error data' do
        authorized_graphql_post(
          query: move_area_within_areas_mutation,
          variables: variables,
          auth_token: token
        )

        expect(response).to match_schema(ExecutionErrorSchema)
        expect(response.status).to be(200)
      end
    end

    context 'when user not authorized' do
      it 'returns error' do
        graphql_post(
          query: move_area_within_areas_mutation,
          variables: variables
        )

        expect(response).to match_schema(AuthenticationErrorSchema)
        expect(response.status).to be(200)
      end
    end
  end
end

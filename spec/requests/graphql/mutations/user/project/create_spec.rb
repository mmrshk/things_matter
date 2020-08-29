# frozen_string_literal: true

describe 'mutation userProjectCreate', type: :request do
  let(:user_account) { create(:user_account) }
  let(:area) { create(:area, user_account: user_account) }
  let(:token) { generate_token(account_id: user_account.id) }
  let(:name) { FFaker::Lorem.word }
  let(:deadline_time) { Time.zone.now + 1.day }
  let(:variables) { { input: { name: name, deadline: deadline_time, type: 'TASK_PROJECT', area_id: area.id } } }

  before { area }

  context 'when success' do
    it 'returns created area of current_user' do
      authorized_graphql_post(
        query: user_project_create_mutation,
        variables: variables,
        auth_token: token
      )

      expect(response).to match_schema(UserProject::CreateSchema)
      expect(response.status).to be(200)
    end
  end

  context 'when failed' do
    context 'when invalid params' do
      let(:variables) { { input: { name: name, deadline: Time.zone.now, type: 'TASK_PROJECT', area_id: area.id } } }

      it 'returns execution error data' do
        authorized_graphql_post(
          query: user_project_create_mutation,
          variables: variables,
          auth_token: token
        )

        expect(response).to match_schema(UserInputErrorSchema)
        expect(response.status).to be(200)
      end
    end

    context 'when passed strange type' do
      let(:variables) { { input: { name: name, type: FFaker::Lorem.word } } }

      it 'returns execution error data' do
        authorized_graphql_post(
          query: user_project_create_mutation,
          variables: variables,
          auth_token: token
        )

        expect(response).to match_schema(ErrorSchema)
        expect(response.status).to be(200)
      end
    end

    context 'when raise ActiveRecord::ActiveRecordError' do
      # rubocop:disable RSpec/AnyInstance
      before { allow_any_instance_of(TaskProject).to receive(:save).and_raise(ActiveRecord::ActiveRecordError) }
      # rubocop:enable RSpec/AnyInstance

      it 'returns execution error data' do
        authorized_graphql_post(
          query: user_project_create_mutation,
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
          query: user_project_create_mutation,
          variables: variables
        )

        expect(response).to match_schema(AuthenticationErrorSchema)
        expect(response.status).to be(200)
      end
    end
  end
end

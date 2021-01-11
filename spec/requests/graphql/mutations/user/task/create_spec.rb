# frozen_string_literal: true

describe 'mutation userTaskCreate', type: :request do
  let(:user_account) { create(:user_account) }
  let(:project) { create(:task_project, user_account: user_account) }
  let(:name) { FFaker::Lorem.word }
  let(:description) { FFaker::Lorem.sentence }

  let(:token) { generate_token(account_id: user_account.id) }

  let(:variables) do
    {
      input: {
        name: name,
        description: description,
        to_do_day: Time.zone.today,
        deadline: Time.zone.today + 7.days,
        task_project_id: project.id
      }
    }
  end

  context 'when success' do
    it 'returns created task of current_user' do
      authorized_graphql_post(
        query: user_task_create_mutation,
        variables: variables,
        auth_token: token
      )

      expect(response).to match_schema(UserTask::CreateSchema)
      expect(response.status).to be(200)
    end
  end

  context 'when failed' do
    context 'when passed strange project_id' do
      let(:variables) { { input: { task_project_id: SecureRandom.uuid } } }

      it 'returns execution error data' do
        authorized_graphql_post(
          query: user_task_create_mutation,
          variables: variables,
          auth_token: token
        )

        expect(response).to match_schema(ErrorSchema)
        expect(response.status).to be(200)
      end
    end

    context 'when raise ActiveRecord::ActiveRecordError' do
      before { allow_any_instance_of(Task).to receive(:save).and_raise(ActiveRecord::ActiveRecordError) }

      it 'returns execution error data' do
        authorized_graphql_post(
          query: user_task_create_mutation,
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
          query: user_task_create_mutation,
          variables: variables
        )

        expect(response).to match_schema(AuthenticationErrorSchema)
        expect(response.status).to be(200)
      end
    end
  end
end

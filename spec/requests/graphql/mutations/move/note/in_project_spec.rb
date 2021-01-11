# frozen_string_literal: true

describe 'mutation moveNoteInProject', type: :request do
  let_it_be(:user_account) { create(:user_account) }
  let(:project) { create(:note_project, with_notes: true, note_count: 4, user_account: user_account) }

  let(:token) { generate_token(account_id: user_account.id) }

  let(:variables) do
    {
      input: {
        id: project.notes.fourth.id,
        position: 1
      }
    }
  end

  context 'when success' do
    it 'returns success result' do
      authorized_graphql_post(
        query: move_note_in_project_mutation,
        variables: variables,
        auth_token: token
      )

      expect(response).to match_schema(Move::Note::InProject)
      expect(response.status).to be(200)
    end
  end

  context 'when failed' do
    context 'when passed strange id' do
      let(:variables) { { input: { id: SecureRandom.uuid } } }

      it 'returns execution error data' do
        authorized_graphql_post(
          query: move_note_in_project_mutation,
          variables: variables,
          auth_token: token
        )

        expect(response).to match_schema(ErrorSchema)
        expect(response.status).to be(200)
      end
    end

    context 'when raise ActiveRecord::ActiveRecordError' do
      before { allow_any_instance_of(Note).to receive(:update!).and_raise(ActiveRecord::ActiveRecordError) }

      it 'returns execution error data' do
        authorized_graphql_post(
          query: move_note_in_project_mutation,
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
          query: move_note_in_project_mutation,
          variables: variables
        )

        expect(response).to match_schema(AuthenticationErrorSchema)
        expect(response.status).to be(200)
      end
    end
  end
end

# frozen_string_literal: true

describe 'notes query', type: :request do
  let!(:user_account) { create(:user_account) }
  let(:token) { generate_token(account_id: user_account.id) }

  let(:note_project) { create(:note_project, with_notes: true, user_account: user_account) }

  before { note_project }

  context 'when user account' do
    context 'when without sort' do
      it 'returns all data' do
        authorized_graphql_post(
          query: notes_guery,
          variables: {},
          auth_token: token
        )

        expect(response).to match_schema(UserNote::NotesSchema)
        expect(response.status).to be(200)
      end
    end

    context 'when with sort' do
      it 'returns today data' do
        authorized_graphql_post(
          query: notes_guery,
          variables: { input: { sort: 'NAME' } },
          auth_token: token
        )

        expect(response).to match_schema(UserNote::NotesSchema)
        expect(response.status).to be(200)
      end
    end

    context 'when with sort' do
      it 'returns today data' do
        authorized_graphql_post(
          query: notes_guery,
          variables: { input: { sort: 'CREATED_AT', direction: 'DESC' } },
          auth_token: token
        )

        expect(response).to match_schema(UserNote::NotesSchema)
        expect(response.status).to be(200)
      end
    end
  end

  context 'when no account' do
    it 'returns authentication error data' do
      graphql_post(
        query: notes_guery
      )

      expect(response).to match_schema(AuthenticationErrorSchema)
      expect(response.status).to be(200)
    end
  end
end

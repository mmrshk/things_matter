# frozen_string_literal: true

describe Api::V1::User::Note::Tag::Operation::Delete, type: :operation do
  subject(:execute_operation) { described_class.call(params: params, current_user: current_user) }

  let(:current_user) { create(:user_account) }
  let(:note) { create(:note, user_account: current_user) }
  let(:note_tag) { create(:note_tag, note: note) }
  let(:params) { { id: note_tag.id } }

  before { note_tag }

  context 'when user deletes note tag' do
    it 'deletes note tag' do
      expect { execute_operation }.to change(NoteTag, :count).from(1).to(0)
    end

    it 'returns success result' do
      expect(execute_operation['result'][:completed]).to eq(true)
    end

    it 'success operation' do
      expect(execute_operation).to be_success
    end
  end

  context 'when note tag id NOT exist' do
    let(:params) { { id: SecureRandom.uuid } }

    it 'NOT deletes note' do
      expect { execute_operation }.not_to change(NoteTag, :count)
    end

    it 'failure operation' do
      expect(execute_operation).to be_failure
    end
  end

  context 'when user not authorized to action' do
    let(:note_tag) { create(:note_tag) }

    it 'NOT deletes note' do
      expect { execute_operation }.not_to change(NoteTag, :count)
    end

    it 'failure operation' do
      expect(execute_operation).to be_failure
    end
  end
end

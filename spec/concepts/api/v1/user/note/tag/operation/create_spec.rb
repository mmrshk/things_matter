# frozen_string_literal: true

describe Api::V1::User::Note::Tag::Operation::Create, type: :operation do
  subject(:execute_operation) { described_class.call(params: params, current_user: current_user) }

  let(:current_user) { create(:user_account) }
  let(:note) { create(:note, user_account: current_user) }
  let(:name) { FFaker::Lorem.word }
  let(:params) { { name: name, note_id: note.id } }

  context 'when user creates note tag' do
    it 'creates NoteTag' do
      expect { execute_operation }.to change(NoteTag, :count).from(0).to(1)
    end

    it 'returns status' do
      expect(execute_operation['result']).to be_truthy
    end

    it 'success operation' do
      expect(execute_operation).to be_success
    end
  end

  context 'when user not passes note_id' do
    let(:params) { { name: name } }

    it 'NOT creates NoteTag' do
      expect { execute_operation }.not_to change(NoteTag, :count)
    end

    it 'failure operation' do
      expect(execute_operation).to be_failure
    end
  end

  context 'when user not authorized to action' do
    let(:note) { create(:note) }

    it 'NOT creates NoteTag' do
      expect { execute_operation }.not_to change(NoteTag, :count)
    end

    it 'failure operation' do
      expect(execute_operation).to be_failure
    end
  end
end

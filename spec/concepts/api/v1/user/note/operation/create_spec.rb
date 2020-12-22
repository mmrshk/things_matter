# frozen_string_literal: true

describe Api::V1::User::Note::Operation::Create, type: :operation do
  subject(:execute_operation) { described_class.call(params: params, current_user: current_user) }

  let(:current_user) { create(:user_account) }
  let(:project) { create(:note_project, user_account: current_user) }
  let(:name) { FFaker::Lorem.word }
  let(:description) { FFaker::Lorem.sentence }

  let(:default_note) { create(:note, default: true) }

  let(:token) { generate_token(account_id: current_user.id) }

  let(:params) do
    {
      name: name,
      description: description,
      default: true,
      note_project_id: project.id,
      note_images: [
        {
          id: SecureRandom.uuid,
          signed_blob_id: ActiveStorage::Blob.create_before_direct_upload!(
            filename: 'test.jpg', byte_size: 10, checksum: 'checksum'
          ).signed_id
        },
        {
          id: SecureRandom.uuid,
          signed_blob_id: ActiveStorage::Blob.create_before_direct_upload!(
            filename: 'test.jpg', byte_size: 10, checksum: 'checksum'
          ).signed_id
        }
      ]
    }
  end

  before do
    allow_any_instance_of(ActiveStorage::Service::DiskService).to receive(:download_chunk).and_return('\x10\x00\x00')
  end

  context 'when user creates note' do
    it 'creates Note' do
      expect { execute_operation }.to change(Note, :count).from(0).to(1)
    end

    it 'creates 2 TaskImages' do
      expect { execute_operation }.to change(NoteImage, :count).from(0).to(2)
    end

    it 'changes previous default Note' do
      expect { execute_operation && default_note.reload }.to change(default_note, :default).from(true).to(false)
    end

    it 'returns user_account' do
      expect(execute_operation['result']).to eq(current_user)
    end

    it 'success operation' do
      expect(execute_operation).to be_success
    end
  end

  context 'when user creates project WITHOUT name and WITHOUT description' do
    let(:params) { { default: true, note_project_id: project.id } }

    it 'creates Note' do
      expect { execute_operation }.to change(Note, :count).from(0).to(1)
    end

    it 'returns user_account' do
      expect(execute_operation['result']).to eq(current_user)
    end

    it 'success operation' do
      expect(execute_operation).to be_success
    end
  end

  context 'when user creates project WITH area that not belongs to user' do
    let(:project) { create(:note_project) }

    it 'NOT creates Note' do
      expect { execute_operation }.not_to change(Note, :count)
    end

    it 'failure operation' do
      expect(execute_operation).to be_failure
    end
  end

  context 'when user not passes project_id' do
    let(:params) { { default: true } }

    it 'NOT creates Note' do
      expect { execute_operation }.not_to change(Note, :count)
    end

    it 'failure operation' do
      expect(execute_operation).to be_failure
    end
  end

  context 'when user not authorized to action' do
    let(:project) { create(:note_project) }
    let(:current_user) { nil }

    it 'NOT creates Note' do
      expect { execute_operation }.not_to change(Note, :count)
    end

    it 'failure operation' do
      expect(execute_operation).to be_failure
    end
  end
end

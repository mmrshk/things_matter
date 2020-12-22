# frozen_string_literal: true

describe Api::V1::User::Note::Operation::Update, type: :operation do
  subject(:execute_operation) { described_class.call(params: params, current_user: current_user) }

  let(:current_user) { create(:user_account) }
  let(:project) { create(:note_project, user_account: current_user) }
  let(:note) { create(:note, note_project: project, with_image: true, image_count: 2) }
  let(:name) { FFaker::Lorem.word }
  let(:description) { FFaker::Lorem.sentence }

  let(:params) do
     {
       id: note.id,
       name: name,
       description: description,
       note_images: [
        {
          id: note.note_images.first.id,
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

    note
  end

  context 'when user updates project' do
    it 'updates project' do
      expect { execute_operation && note.reload }.to change(note, :name).from(note.name).to(name)
    end

    it 'not to change count (count not chages cause initially 2 images - than 1 deletes, 1 creates' do
      expect { execute_operation && note.reload }.not_to change(NoteImage, :count)
    end

    it 'returns user_account' do
      expect(execute_operation['result']).to eq(current_user)
    end

    it 'success operation' do
      expect(execute_operation).to be_success
    end
  end

  context 'when user changes project for note' do
    let(:new_project) { create(:note_project, user_account: current_user) }
    let(:params) { { id: note.id, note_project_id: new_project.id } }

    it 'updates project' do
      expect do
        execute_operation && note.reload
      end.to change(note, :note_project_id).from(note.note_project_id).to(new_project.id)
    end

    it 'returns user_account' do
      expect(execute_operation['result']).to eq(current_user)
    end

    it 'success operation' do
      expect(execute_operation).to be_success
    end
  end

  context 'when note id NOT exist' do
    let(:params) { { id: SecureRandom.uuid, name: name } }

    it 'NOT updates project' do
      expect { execute_operation && project.reload }.not_to change(project, :name)
    end

    it 'failure operation' do
      expect(execute_operation).to be_failure
    end
  end

  context 'when user not authorized to action' do
    let(:project) { create(:note_project) }

    it 'NOT updates project' do
      expect { execute_operation && project.reload }.not_to change(project, :name)
    end

    it 'failure operation' do
      expect(execute_operation).to be_failure
    end
  end
end

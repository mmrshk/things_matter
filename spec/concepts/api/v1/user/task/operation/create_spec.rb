# frozen_string_literal: true

describe Api::V1::User::Task::Operation::Create, type: :operation do
  subject(:execute_operation) { described_class.call(params: params, current_user: current_user) }

  let(:current_user) { create(:user_account) }
  let(:project) { create(:task_project, user_account: current_user) }
  let(:name) { FFaker::Lorem.word }
  let(:description) { FFaker::Lorem.sentence }

  let(:token) { generate_token(account_id: current_user.id) }

  let(:params) do
    {
      name: name,
      description: description,
      to_do_day: Time.zone.today + 1.day,
      deadline: Time.zone.today + 7.days,
      task_project_id: project.id,
      task_images: [
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

  context 'when user creates task' do
    it 'creates Task' do
      expect { execute_operation }.to change(Task, :count).from(0).to(1)
    end

    it 'creates 2 TaskImages' do
      expect { execute_operation }.to change(TaskImage, :count).from(0).to(2)
    end

    it 'returns user_account' do
      expect(execute_operation['result']).to eq(current_user)
    end

    it 'success operation' do
      expect(execute_operation).to be_success
    end
  end

  context 'when user creates project WITHOUT name and WITHOUT description' do
    let(:params) { { default: true, task_project_id: project.id } }

    it 'creates Task' do
      expect { execute_operation }.to change(Task, :count).from(0).to(1)
    end

    it 'returns user_account' do
      expect(execute_operation['result']).to eq(current_user)
    end

    it 'success operation' do
      expect(execute_operation).to be_success
    end
  end

  context 'when user creates project WITH area that not belongs to user' do
    let(:project) { create(:task_project) }

    it 'NOT creates Task' do
      expect { execute_operation }.not_to change(Task, :count)
    end

    it 'failure operation' do
      expect(execute_operation).to be_failure
    end
  end

  context 'when user not passes project_id' do
    let(:params) { { default: true } }

    it 'NOT creates Task' do
      expect { execute_operation }.not_to change(Task, :count)
    end

    it 'failure operation' do
      expect(execute_operation).to be_failure
    end
  end

  context 'when user not authorized to action' do
    let(:project) { create(:task_project) }
    let(:current_user) { nil }

    it 'NOT creates Task' do
      expect { execute_operation }.not_to change(Task, :count)
    end

    it 'failure operation' do
      expect(execute_operation).to be_failure
    end
  end
end

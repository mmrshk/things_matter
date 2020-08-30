# frozen_string_literal: true

describe Api::V1::User::Project::Operation::Update, type: :operation do
  subject(:execute_operation) { described_class.call(params: params, current_user: current_user) }

  let(:current_user) { create(:user_account) }
  let(:project) { create(:project, user_account: current_user) }
  let(:name) { FFaker::Lorem.word }

  let(:params) { { id: project.id, name: name } }

  context 'when user updates project' do
    it 'updates project' do
      expect { execute_operation && project.reload }.to change(project, :name).from(project.name).to(name)
    end

    it 'returns user_account' do
      expect(execute_operation['result']).to eq(current_user)
    end

    it 'success operation' do
      expect(execute_operation).to be_success
    end
  end

  context 'when user updates project and removes area' do
    let(:params) { { id: project.id, area_id: nil } }

    it 'updates project' do
      expect { execute_operation && project.reload }.to change(project, :area_id).from(project.area_id).to(nil)
    end

    it 'returns user_account' do
      expect(execute_operation['result']).to eq(current_user)
    end

    it 'success operation' do
      expect(execute_operation).to be_success
    end
  end

  context 'when project id NOT exist' do
    let(:params) { { id: SecureRandom.uuid, name: name } }

    it 'NOT updates project' do
      expect { execute_operation && project.reload }.not_to change(project, :name)
    end

    it 'failure operation' do
      expect(execute_operation).to be_failure
    end
  end

  context 'when user not authorized to action' do
    let(:project) { create(:project) }

    it 'NOT updates project' do
      expect { execute_operation && project.reload }.not_to change(project, :name)
    end

    it 'failure operation' do
      expect(execute_operation).to be_failure
    end
  end
end

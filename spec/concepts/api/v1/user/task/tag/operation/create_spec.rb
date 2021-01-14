# frozen_string_literal: true

describe Api::V1::User::Task::Tag::Operation::Create, type: :operation do
  subject(:execute_operation) { described_class.call(params: params, current_user: current_user) }

  let(:current_user) { create(:user_account) }
  let(:task) { create(:task, user_account: current_user) }
  let(:name) { FFaker::Lorem.word }
  let(:params) { { name: name, task_id: task.id } }

  context 'when user creates task tag' do
    it 'creates TaskTag' do
      expect { execute_operation }.to change(TaskTag, :count).from(0).to(1)
    end

    it 'returns status' do
      expect(execute_operation['result']).to be_truthy
    end

    it 'success operation' do
      expect(execute_operation).to be_success
    end
  end

  context 'when user not passes task_id' do
    let(:params) { { name: name } }

    it 'NOT creates TaskTag' do
      expect { execute_operation }.not_to change(TaskTag, :count)
    end

    it 'failure operation' do
      expect(execute_operation).to be_failure
    end
  end

  context 'when user not authorized to action' do
    let(:task) { create(:task) }

    it 'NOT creates TaskTag' do
      expect { execute_operation }.not_to change(TaskTag, :count)
    end

    it 'failure operation' do
      expect(execute_operation).to be_failure
    end
  end
end

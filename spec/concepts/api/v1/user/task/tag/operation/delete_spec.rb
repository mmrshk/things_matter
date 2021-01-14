# frozen_string_literal: true

describe Api::V1::User::Task::Tag::Operation::Delete, type: :operation do
  subject(:execute_operation) { described_class.call(params: params, current_user: current_user) }

  let(:current_user) { create(:user_account) }
  let(:task) { create(:task, user_account: current_user) }
  let(:task_tag) { create(:task_tag, task: task) }
  let(:params) { { id: task_tag.id } }

  before { task_tag }

  context 'when user deletes task tag' do
    it 'deletes task tag' do
      expect { execute_operation }.to change(TaskTag, :count).from(1).to(0)
    end

    it 'returns success result' do
      expect(execute_operation['result'][:completed]).to eq(true)
    end

    it 'success operation' do
      expect(execute_operation).to be_success
    end
  end

  context 'when task tag id NOT exist' do
    let(:params) { { id: SecureRandom.uuid } }

    it 'NOT deletes task' do
      expect { execute_operation }.not_to change(TaskTag, :count)
    end

    it 'failure operation' do
      expect(execute_operation).to be_failure
    end
  end

  context 'when user not authorized to action' do
    let(:task_tag) { create(:task_tag) }

    it 'NOT deletes task' do
      expect { execute_operation }.not_to change(Task, :count)
    end

    it 'failure operation' do
      expect(execute_operation).to be_failure
    end
  end
end

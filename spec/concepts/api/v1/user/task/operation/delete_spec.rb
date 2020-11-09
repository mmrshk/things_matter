# frozen_string_literal: true

describe Api::V1::User::Task::Operation::Delete, type: :operation do
  subject(:execute_operation) { described_class.call(params: params, current_user: current_user) }

  let(:current_user) { create(:user_account) }
  let(:project) { create(:task_project, user_account: current_user) }
  let(:task) { create(:task, user_account: current_user, task_project: project) }

  let(:params) { { id: task.id } }

  before { task }

  context 'when user deletes task' do
    it 'deletes task' do
      expect do
        execute_operation && task.reload
      end.to change(task, :deleted).from(false).to(true).and(
        change(task, :deleted_date).from(task.deleted_date).to(Time.zone.today)
      )
    end

    it 'returns success result' do
      expect(execute_operation['result'][:completed]).to eq(true)
    end

    it 'success operation' do
      expect(execute_operation).to be_success
    end
  end

  context 'when task id NOT exist' do
    let(:params) { { id: SecureRandom.uuid } }

    it 'NOT deletes task' do
      expect { execute_operation }.not_to change(Task, :count)
    end

    it 'failure operation' do
      expect(execute_operation).to be_failure
    end
  end

  context 'when user not authorized to action' do
    let(:project) { create(:task_project) }

    it 'NOT deletes task' do
      expect { execute_operation }.not_to change(Task, :count)
    end

    it 'failure operation' do
      expect(execute_operation).to be_failure
    end
  end
end

# frozen_string_literal: true

describe Api::V1::User::Task::Operation::Recover, type: :operation do
  subject(:execute_operation) { described_class.call(params: params, current_user: current_user) }

  let(:current_user) { create(:user_account) }
  let(:token) { generate_token(account_id: current_user.id) }
  let(:project) { create(:task_project, user_account: current_user) }
  let(:task) { create(:task, user_account: current_user, task_project: project, is_deleted: true) }
  let(:params) { { id: task.id } }

  context 'when recovers task and project exist' do
    it 'updates task' do
      expect do
        execute_operation && task.reload
      end.to change(task, :deleted).from(true).to(false).and(
        change(task, :deleted_date).from(task.deleted_date).to(nil)
      )
    end

    it 'returns user_account' do
      expect(execute_operation['result']).to eq(current_user)
    end

    it 'success operation' do
      expect(execute_operation).to be_success
    end
  end

  context 'when recovers task and project NOT exist' do
    context 'when task_location today' do
      let(:task) { create(:task, user_account: current_user, without_task_project: true, is_deleted: true) }
      let(:params) { { id: task.id, task_location: 'today' } }

      it 'updates task' do
        expect do
          execute_operation && task.reload
        end.to change(task, :deleted).from(true).to(false).and(
          change(task, :deleted_date).from(task.deleted_date).to(nil)
        ).and(
          change(task, :to_do_day).from(task.to_do_day).to(Time.zone.today)
        )
      end

      it 'returns user_account' do
        expect(execute_operation['result']).to eq(current_user)
      end

      it 'success operation' do
        expect(execute_operation).to be_success
      end
    end

    context 'when task_location anytime' do
      let(:params) { { id: task.id, task_location: 'anytime' } }
      let(:task) { create(:task, user_account: current_user, without_task_project: true, is_deleted: true, done: true) }

      it 'updates task' do
        expect do
          execute_operation && task.reload
        end.to change(task, :deleted).from(true).to(false).and(
          change(task, :deleted_date).from(task.deleted_date).to(nil)
        ).and(
          change(task, :done).from(task.done).to(false)
        )
      end

      it 'returns user_account' do
        expect(execute_operation['result']).to eq(current_user)
      end

      it 'success operation' do
        expect(execute_operation).to be_success
      end
    end
  end

  context 'when task id NOT exist' do
    let(:params) { { id: SecureRandom.uuid } }

    it 'failure operation' do
      expect(execute_operation).to be_failure
    end
  end
end

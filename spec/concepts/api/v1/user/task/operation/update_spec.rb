# frozen_string_literal: true

describe Api::V1::User::Task::Operation::Update, type: :operation do
  subject(:execute_operation) { described_class.call(params: params, current_user: current_user) }

  let(:current_user) { create(:user_account) }
  let(:project) { create(:task_project, user_account: current_user) }
  let(:task) { create(:task, task_project: project) }

  let(:name) { FFaker::Lorem.word }
  let(:description) { FFaker::Lorem.sentence }

  let(:token) { generate_token(account_id: current_user.id) }

  let(:params) do
    {
      id: task.id,
      name: name,
      description: description,
      to_do_day: Date.today + 1.day,
      deadline: Date.today + 6.days
    }
  end

  context 'when user updates task' do
    it 'updates task' do
      expect {
        execute_operation && task.reload
      }.to change(task, :name).from(task.name).to(name).and(
        change(task, :description).from(task.description).to(description)
      ).and(
        change(task, :to_do_day).from(task.to_do_day).to(params[:to_do_day])
      ).and(
        change(task, :deadline).from(task.deadline).to(params[:deadline])
      )
    end

    it 'returns user_account' do
      expect(execute_operation['result']).to eq(current_user)
    end

    it 'success operation' do
      expect(execute_operation).to be_success
    end
  end

  context 'when user changes project for task' do
    let(:new_project) { create(:task_project, user_account: current_user) }
    let(:params) { { id: task.id, task_project_id: new_project.id } }

    it 'updates project' do
      expect {
        execute_operation && task.reload
      }.to change(task, :task_project_id).from(task.task_project_id).to(new_project.id)
    end

    it 'returns user_account' do
      expect(execute_operation['result']).to eq(current_user)
    end

    it 'success operation' do
      expect(execute_operation).to be_success
    end
  end

  context 'when task id NOT exist' do
    let(:params) { { id: SecureRandom.uuid, name: name } }

    it 'NOT updates project' do
      expect { execute_operation && project.reload }.not_to change(project, :name)
    end

    it 'failure operation' do
      expect(execute_operation).to be_failure
    end
  end

  context 'when user not authorized to action' do
    let(:project) { create(:task_project) }

    it 'NOT updates project' do
      expect { execute_operation && project.reload }.not_to change(project, :name)
    end

    it 'failure operation' do
      expect(execute_operation).to be_failure
    end
  end
end

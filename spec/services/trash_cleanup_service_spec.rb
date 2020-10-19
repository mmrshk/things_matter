# frozen_string_literal: true

describe TrashCleanupService do
  subject(:service) { described_class.call }

  let(:user_account) { create(:user_account, with_user_profile: true) }
  let!(:task_project) { create(:task_project, with_deleted_tasks: true, deleted: true, user_account: user_account ) }
  let!(:note_project) { create(:note_project, with_deleted_notes: true, deleted: true, user_account: user_account) }

  context 'when removes all entities' do
    it 'success' do
      expect { service }.to change(TaskProject, :count).from(1).to(0).and(
        change(NoteProject, :count).from(1).to(0)
      ).and(
        change(Task, :count).from(2).to(0)
      ).and(
        change(Note, :count).from(2).to(0)
      )
    end
  end
end

require 'rails_helper'

describe UserPolicy do
  subject { UserPolicy.new(user, record) }

  let(:record) { create :user }

  context 'for an admin' do
    let(:user) { create :user, :admin }

    it { is_expected.to permit_actions(%i[index show create update destroy]) }
  end

  context 'for a client' do
    let(:user) { create :user, :client }

    it { is_expected.to permit_actions(%i[create]) }
    it { is_expected.to forbid_actions(%i[index show update destroy]) }
  end

  context 'for client with their account' do
    let(:user) { record }
    it { is_expected.to permit_actions(%i[create show update]) }
    it { is_expected.to forbid_actions(%i[index destroy]) }
  end
end

require 'rails_helper'

describe ProductPolicy do
  subject { ProductPolicy.new(user, product) }

  let(:product) { create :product }

  context 'for an admin' do
    let(:user) { create :user, :admin }

    it { is_expected.to permit_actions(%i[index show create new update edit destroy]) }
  end

  context 'for a client' do
    let(:user) { create :user, :client }

    it { is_expected.to permit_actions(%i[index show]) }
    it { is_expected.to forbid_actions(%i[create new update edit destroy]) }
  end
end

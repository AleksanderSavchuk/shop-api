# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Product, type: :model do
  context 'ActiveStorage' do
    let(:product) { create :product }
    context 'bla' do
      it { expect(true).to eq false }
    end
    context 'success' do
      it 'successfully attached photo' do
        expect(product.photo.attached?).to eq false
        product.photo.attach(io: File.open(Rails.root.join('spec/support/files/1zayceva.jpg')),
                             filename: '1zayceva.jpg')
        expect(product.photo.attached?).to eq true
      end
    end
  end
end

# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do
  describe 'full title helper' do
    it 'return root title' do
      expect(full_title).to eq('ElectroNote')
    end
    it 'return general title' do
      expect(full_title('Help')).to eq('Help | ElectroNote')
    end
  end
end

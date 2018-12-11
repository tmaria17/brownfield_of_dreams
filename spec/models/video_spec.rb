require 'rails_helper'

RSpec.describe Video, type: :model do
  describe 'validations' do
    it {should validate_presence_of(:position)}
  end

  describe 'relationships' do
    it {should have_many(:user_videos)}
    it {should have_many(:users).through(:user_videos)}
    it {should belong_to(:tutorial)}
  end

  describe 'Class methods' do
    it 'should assign a video position if position is nil' do
      tutorial = create(:tutorial)
      video1 = create(:video, tutorial_id: tutorial.id, position: 1)
      video2 = create(:video, tutorial_id: tutorial.id)
      video2.update_attribute(:position, nil)

      Video.position_assignment

      expect(Video.last.position).to eq(2)
      expect(video1.position).to eq(1)
      expect(video2.position).to eq(2)
    end
  end
end

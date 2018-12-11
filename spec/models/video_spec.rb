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
      video2 = create(:video, tutorial_id: tutorial.id, position: 2)
      video3 = create(:video, tutorial_id: tutorial.id)

      video3.update_attribute(:position, nil)
      expect(Video.last.position).to eq(nil)

      Video.position_assignment

      expect(Video.last.position).to eq(3)
      expect(video3.reload.position).to eq(3)
    end
  end
end

require 'rails_helper'

RSpec.describe UserVideo, type: :model do
  describe 'realationships' do
    it {should belong_to(:video)}
    it {should belong_to(:user)}

  end
end

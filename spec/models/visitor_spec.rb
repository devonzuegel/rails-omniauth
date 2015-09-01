require 'rails_helper'

RSpec.describe Visitor, type: :model do
  describe 'basic visitor' do
    before(:each) { @visitor = create(:visitor) }

    it { should respond_to(:ip_address) }
    it { should respond_to(:user_id) }
    it { should respond_to(:view_count) }
    it { should respond_to(:public_posts) }
  end
end

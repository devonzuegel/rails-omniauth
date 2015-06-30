# encoding: utf-8
describe User do
  before(:each) { @user = FactoryGirl.create(:user) }
  subject { @user }
  it { should respond_to(:name) }

  it 'factory user created as expected' do
    expect(@user).to be_valid
    expect(@user.provider).to match 'facebook'
  end

  it 'mock auth user created as expected' do
    expect do
      @user = User.create_with_omniauth(auth_mock_hash)
    end.to change { User.count }.by 1

    values = auth_mock_hash['info'].merge(provider: auth_mock_hash['provider'],
                                          uid:      auth_mock_hash['uid'])
    expect(@user).to have_attributes(values)
  end

  it 'mock user with nil info attributes created as expected' do
    info = {
      name:        nil,
      first_name:  nil,
      middle_name: nil,
      last_name:   nil,
      email:       nil
    }
    expect do
      @user = User.create_with_omniauth(auth_mock_hash.merge('info' => info))
    end.to change { User.count }.by 1

    expect(@user).to have_attributes(Utils.blank_params_to_nil({
      provider: auth_mock_hash['provider'],
      uid:      auth_mock_hash['uid']
    }.merge(info)))
  end

  it 'mock user with blank info attributes created as expected' do
    info = {
      name:        '    ',
      first_name:  '    ',
      middle_name: '    ',
      last_name:   '    ',
      email:       '    '
    }
    expect do
      @user = User.create_with_omniauth(auth_mock_hash.merge('info' => info))
    end.to change { User.count }.by 1

    expect(@user).to have_attributes(Utils.blank_params_to_nil({
      provider: auth_mock_hash['provider'],
      uid:      auth_mock_hash['uid']
    }.merge(info)))
  end

  it 'should destroy account and all entries when deleted' do
    @user_to_destroy = FactoryGirl.create(:user, :with_5_entries)
    expect { @user_to_destroy.destroy }.to change { Entry.count }.by(-5)
  end

  it 'should be invalid without an account' do
    expect(User.new).to be_invalid
  end

  it 'should be invalid with any blank names or blank email' do
    expect(build(:user, first_name:  '    ')).to be_invalid
    expect(build(:user, middle_name: '    ')).to be_invalid
    expect(build(:user, last_name:   '    ')).to be_invalid
    expect(build(:user, email:       '    ')).to be_invalid

    # NOTE: FactoryGirl :name is built from first, middle, and last names.
    expect(build(:user, name: ' ')).to be_valid
  end
end

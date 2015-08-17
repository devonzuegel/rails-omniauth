describe 'accounts/show' do
  before do
    @account_form = {
      path: account_path,
      signed_in: true,
      submit_value: 'Save'
    }
    @user    = create(:user)
    @visitor = create(:visitor, user: @user)
    assign(:current_user, @user)
    assign(:account, @user.account)
    render
  end

  it 'has a profile picture' do
    expect(rendered).to have_selector '.profile-pic.circle'
  end

  it 'has your api key' do
    expect(rendered).to have_content 'API key:'
    expect(rendered).to have_content @user.api_key
  end

  it 'has name field' do
    expect(rendered).to have_selector 'input#account_user_attributes_name'
  end

  it 'has a theme dropdown' do
    expect(rendered).to have_selector 'select#account_theme'
  end

  it 'has the public posts radio buttons' do
    expect(rendered).to have_selector '.radio_buttons.account_public_posts'
    expect(rendered).to have_selector 'input.radio_buttons#account_public_posts_false'
    expect(rendered).to have_selector 'input.radio_buttons#account_public_posts_true'
  end

  it 'has a timezone dropdown' do
    expect(rendered).to have_selector 'select#account_timezone'
  end
end

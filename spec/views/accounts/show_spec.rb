describe 'accounts/show' do
  before do
    @account_form = {
      path: account_path,
      signed_in: true,
      submit_value: 'Save'
    }
  end

  it 'displays the account' do
    assign(:account, create(:account))
    assign(:current_user, create(:user))
    render
    # puts rendered

    expect(rendered).to have_content('Your Account')
  end

  it '...'
end

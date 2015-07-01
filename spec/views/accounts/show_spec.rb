describe 'accounts/show' do
  before do
    @account_form = {
      path: account_path,
      signed_in: true,
      submit_value: 'Save'
    }
  end

  it 'displays the account' do
    current_user = create(:user)
    assign(:current_user, current_user)
    assign(:account, current_user.account)
    render
    # puts rendered

    expect(rendered).to have_content('Your Account')
  end

  it 'has a timezone dropdown... and ALL OTHERS!'

  it '...'
end

# /zen-writer/spec/support/helpers/utils.rb
module SpecUtils
  # Usage:
  # fill_form_and_save({
  #   name: "account[user_attributes]",
  #   attributes: { first_name: "James", last_name: "Smith" },
  #   submit_value: "Save"
  # })
  def fill_form_and_save(hash)
    sign_in_feature if hash[:signed_in] && !signed_in?
    visit hash[:path]
    hash[:attributes].each do |key, val|
      selector = "#{hash[:name]}[#{key}]".gsub(/\[\]/, '_')
      fill_in selector, with: val
    end
    click_button hash[:submit_value]
  end

  # Usage:
  # path_should_be(root_path)
  def path_should_be(expected_path)
    expect(current_path).to match expected_path
  end

  def sign_in
    expect(session[:user_id]).to be_nil
    @user = create(:user)
    @account = @user.account
    session[:user_id] = @user.id
    expect(session[:user_id]).not_to be_nil
  end

  def create_valid_entry
    entry_data = { title: 'MyTitle', body: 'This is the body.' }
    visit root_path
    fill_in 'entry[title]', with: entry_data[:title]
    click_button 'Start writing'
    sleep 0.1
    expect(page.body).to include(entry_data[:title])
    path_should_be(%r{^\/entries\/\d+\/freewrite$})
    click_button "I'm done"
  end

  def parsed(response)
    JSON.parse(response.body)
  end
end

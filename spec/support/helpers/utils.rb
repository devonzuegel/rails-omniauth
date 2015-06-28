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
    fill_in "#{hash[:name]}[#{key}]", with: val
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
  @user = FactoryGirl.create(:user)
  @account = @user.account
  session[:user_id] = @user.id
  expect(session[:user_id]).not_to be_nil
end

def current_user
  User.find(session[:user_id]) if session
end

def signed_in?
  !!current_user
end

# Usage:
  # fill_form_and_save({
  #   name: "account[user_attributes]", 
  #   attributes: { first_name: "James", last_name: "Smith" }, 
  #   submit_value: "Save"
  # })
def fill_form_and_save hash
  signin if hash[:signed_in] && !signed_in?
  visit hash[:path]
  hash[:attributes].each do |key, val|
    fill_in "#{hash[:name]}[#{key}]", with: val
  end
  click_button hash[:submit_value]
end


# Usage:
  # path_should_be(root_path)
def path_should_be expected_path
  expect(current_path).to match expected_path
end

# Usage:  expect(9).to be_a_multiple_of(3)
RSpec::Matchers.define :be_a_multiple_of do |expected|
  match do |actual|
    actual % expected == 0
  end
end

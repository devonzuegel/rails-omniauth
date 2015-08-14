2.times do
  Entry.create(
    title:      Faker::Lorem.sentences(1).first,
    body:       Faker::Lorem.paragraphs.join("\n"),
    created_at: Faker::Date.between(1.year.ago, 3.months.ago),
    updated_at: Faker::Date.between(1.month.ago, Time.zone.today),
    public:     [true, false].sample
  )
end

# User.create(
#   email: 'test@example.com',
#   name: 'Devon Zuegel',
#   account: Account.create
# )

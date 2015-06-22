# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

for i in 1..30 do 
  Entry.create({ 
    title: Faker::Lorem.sentences(1).first,
    body: Faker::Lorem.paragraphs.join("\n"),
    created_at: Faker::Date.between(1.year.ago, Date.today),
    public: [true, false].sample
  })
end
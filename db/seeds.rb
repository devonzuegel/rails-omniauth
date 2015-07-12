# This file should contain all the record creation needed to seed the
# database with its default values. The data can then be loaded with
# the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

30.times do
  Entry.create(
    title:      Faker::Lorem.sentences(1).first,
    body:       Faker::Lorem.paragraphs.join("\n"),
    created_at: Faker::Date.between(1.year.ago, Time.zone.today),
    public:     [true, false].sample
  )
end

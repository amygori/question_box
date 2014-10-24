# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.delete_all
Question.delete_all
Answer.delete_all
Vote.delete_all

user = User.create!(name:                  Faker::Name.name,
                    email:                 "user@example.org",
                    password:              "password",
                    password_confirmation: "password")

other_users = Array.new(10).map { |_| User.create!(name:                  Faker::Name.name,
                                                   email:                 Faker::Internet.email,
                                                   password:              "password",
                                                   password_confirmation: "password") }

20.times do
  Question.create!(title: "How do I #{Faker::Hacker.verb} #{['a', 'the'].sample} #{Faker::Hacker.noun}?",
                   text:  Faker::Hacker.say_something_smart,
                   user:  user)
end

questions = Question.all

20.times do
  Answer.create!(question: questions.sample,
                 text:     Faker::Hacker.say_something_smart,
                 user:     other_users.sample)
end

30.times do
  Vote.create!(voteable: questions.sample,
               user:     other_users.sample,
               value:    [1, 1, 1, 1, 1, -1].sample)
end
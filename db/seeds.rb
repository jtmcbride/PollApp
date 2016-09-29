# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
User.create([{user_name: "moo"},{user_name: "cow"},{user_name: "guy"},{user_name: "lady"},{user_name: "cat"},{user_name: "stuff"},{user_name: "polls"}])
Poll.create([{title: "hi", author_id: 1},{title: "the", author_id: 1},{title: "hello", author_id: 1},{title: "why", author_id: 1},{title: "yes", author_id: 1},{title: "no", author_id: 1},
  {title: "be", author_id: 3},{title: "loo", author_id: 3}])
  
arr = ('a'..'g').to_a
(1..8).each do |poll|
  5.times do
    Question.create(body: arr.shuffle.join,poll_id: poll)
  end
end

40.times do |i|
  AnswerChoice.create([{choice: "yes", question_id: i + 1},{choice: "no", question_id: i + 1}])
end

10.times do
  Response.create([{user_id: 1, choice_id: (1..40).to_a.sample}])
end

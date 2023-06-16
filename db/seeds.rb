# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
require 'faker'
print "Creating 2 users"
2.times do
    name = Faker::Name.first_name
    password = "#{name}test"
    user = User.create(pseudo:name,email:"#{name}@mail",password: password,password_confirmation:password)
    date = Time.now - rand(0..10).days
    date_exp = date + rand(1..31).days
    Subscription.create(user:user,start_date:date,expiration_date:date_exp)
end
puts " DONE"

print "Creating 10 stories"

10.times do
    name = Faker::Name.first_name
    object = Faker::Games::Minecraft.item
    title = "#{name} and the #{object}"
    Story.create(title: title,theme:"fantasy",age: rand(5..10),first_character: name,fav_object: object, content: Faker::Lorem.sentences  ,user:(User.all.sample),secondary_character: Faker::Name.first_name)
end
puts  " DONE"
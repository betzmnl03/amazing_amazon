# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Review.delete_all 
Product.delete_all

20.times do
    created_at = Faker::Date.backward(days: 365*5)
    p=Product.create(
        title: Faker::Commerce.product_name,
        description:Faker::Commerce.color,
        price: Faker::Number.within(range: 1..10),
        created_at: created_at,
        updated_at: created_at
    )

    if p.valid?
        p.reviews = rand(0..5).times.map do
            Review.new(body: Faker::Restaurant.review, rating: rand(1..5))  #faker::Number min and max are inclusive
        end
    end

    puts p.errors.full_messages
end





product = Product.all
review = Review.all
puts Cowsay.say("Generated #{product.count} products", :dragon)
puts Cowsay.say("Generated #{review.count} reviews", :frogs)



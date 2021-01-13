# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
   
Product.destroy_all
20.times do
    created_at = Faker::Date.backward(days: 365*5)
    Product.create(
        title: Faker::Commerce.product_name,
        description:Faker::Commerce.color,
        price:Faker::Commerce.price,
        created_at: created_at,
        updated_at: created_at
    )

end
p = Product.all
puts Cowsay.say("Generated #{p.count} products", :dragon)



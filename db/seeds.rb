# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Like.delete_all
Tagging.delete_all
Favourite.delete_all

Review.delete_all 
Product.delete_all
User.delete_all


NUM_PRODUCTS=20
NUM_USERS=10
NUM_TAGS=10
PASSWORD='supersecret'

super_user= User.create(
    first_name: 'Jon',
    last_name:'Snow',
    email: 'js@winterfell.gov',
    password: PASSWORD,
    is_admin: true
)

NUM_USERS.times do
    first_name= Faker::Name.first_name 
    last_name= Faker::Name.last_name 
    User.create(
        first_name: first_name,
        last_name: last_name,
        email: "#{first_name}.#{last_name}@example.com",
        password: PASSWORD
    )
    end
    users=User.all

NUM_TAGS.times do
    Tag.create(
        name:Faker::Vehicle.make
    )
end

tags = Tag.all

NUM_PRODUCTS.times do
    created_at = Faker::Date.backward(days: 365*5)
    p=Product.create(
        title: Faker::Commerce.product_name,
        description:Faker::Commerce.color,
        price: Faker::Commerce.price(range: 0..20.0, as_string: false),
        category: Faker::Commerce.department(max: 2, fixed_amount: true),
        created_at: created_at,
        updated_at: created_at,
        user: users.sample
    )

    if p.valid?
        p.reviews = rand(0..5).times.map do
            Review.new(
                body: Faker::Restaurant.review, 
                rating: rand(1..5),
                user: users.sample)  
             
        end
        p.reviews.each do |review|
            review.likers=users.shuffle.slice(0,rand(users.count))
        end
        p.tags= tags.shuffle.slice(0,rand(tags.count))

       
    end

    puts p.errors.full_messages
end





product = Product.all
review = Review.all
puts Cowsay.say("Generated #{product.count} products", :dragon)
puts Cowsay.say("Generated #{review.count} reviews", :frogs)
puts Cowsay.say("Generated #{users.count} users.",:beavis)
puts Cowsay.say("Login with  #{super_user.email} and password:#{PASSWORD}.",:koala)
puts Cowsay.say("Generated #{tags.count} tags.",:sheep)



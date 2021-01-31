# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

def admins_list
    admins = [
        {first_name: "Paul Brian", last_name: "Marcuelo", email: "marcuelo1@gmail.com", nickname: "Brian", password: "marcuelo2"},
        {first_name: "Von Kleo", last_name: "Marcuelo", email: "vonkleomarcuelo@gmail.com", nickname: "Von", password: "marcuelo"},
    ]

    admins
end

admins_list.each do |admin|
    Admin.create(
        first_name: admin[:first_name],
        last_name: admin[:last_name],
        email: admin[:email],
        nickname: admin[:nickname],
        password: admin[:password],
    )
end

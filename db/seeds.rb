# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

['melissa.juarez@michelada.io', 'lenin@michelada.io', 'aranza@michelada.io'].each do |email|
  AdminUser.create(email: email, password: '1234567890')
end

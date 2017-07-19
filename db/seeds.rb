# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
DatabaseCleaner.strategy = :truncation, { except: %w(public.schema_migrations) }
DatabaseCleaner.clean

[{first_name: 'Кенні', last_name: 'Маккормік'},
         {first_name: 'Кайл', last_name: 'Брофловски'},
         {first_name: 'Баттерс', last_name: 'Стотч', blocked: true}].each_with_index do |user, i|
  User.create(user.merge(email: "user#{i}@example.com", password: 'password', birth_date: Date.today - rand(5..30).years))

  20.times do |i|
    recipient_id = User.pluck(:id).sample
    sender_id = User.pluck(:id).sample

    unless (sender_id == recipient_id)
      Message.create(topic: "Прів #{i}", content: "Контент #{i}", sender_id: sender_id, recipient_id: recipient_id)
    end
  end
end
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
User.create!(name: "test_name", email: "test@mail.com", password: 'QWqw123',password_confirmation: 'QWqw123' )
1.upto(5) { |j|
  TaskList.create!(user_id: "1", header: "Test Header #{ j }")
  1.upto(5) {Task.create!(task_list_id: "#{ j }", content: 'Test task', mark: nil, position: "#{ j }",)}
}
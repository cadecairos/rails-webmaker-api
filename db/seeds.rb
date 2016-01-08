# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

user = User.create(username: "cade", language: "en_US")

project = user.projects.create({title: "test project", description: "#description"})

project.pages.create([{
  x: 0,
  y: 0,
}, {
  x: 0,
  y: 1,
}, {
  x: 1,
  y: 0,
}, {
  x: 1,
  y: 1,
}])

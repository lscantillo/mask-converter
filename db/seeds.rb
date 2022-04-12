# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
#

User.create(username: "admin", password: "secret",password_confirmation: "secret", role: "admin", salt: "F^S%QljSfV")
User.create(username: "noadmin", password: "noPow3r",password_confirmation: "noPow3r", role: "editor", salt: "KjvFUC#K*i")
User.create(username: "bob", password: "thisIsNotAPasswordBob",password_confirmation: "thisIsNotAPasswordBob", role: "viewer", salt: "F^S%QljSfV")
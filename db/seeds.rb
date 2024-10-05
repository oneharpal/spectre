# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# Initialize user
unless User.any?
  u = User.new(email: 'admin@example.com')
  u.password = 'admin@123'
  u.save!
end

unless Project.any? || Note.any?
  10.times do |i|
    project = Project.create!(title: Faker::Space.unique.star, description: Faker::GreekPhilosophers.quote)
    5.times do |i|
      project.notes.create(title: Faker::Hipster.word, body: Faker::GreekPhilosophers.quote)
    end
  end
end

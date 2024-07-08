# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
user = User.find_by(name: "Fake User", email: "user@domain.com", username: "user@domain.com", photo: "http://placehold.it/48x48")
if user.nil?
  user = User.new(name: "Fake User", email: "user@domain.com", username: "user@domain.com", photo: "http://placehold.it/48x48", password: "password", password_confirmation: "password")
  user.save
end

app = App.find_or_create_by!(name: "Sample App", icon: "http://placehold.it/48x48", client_id: "sample123")
app.app_redirects.find_or_create_by!(uri: "http://localhost:8000/")
app.app_redirects.find_or_create_by!(uri: "http://localhost:8000/users")
AppSubscription.find_or_create_by!(user_id: user.id, app_id: app.id)

app = App.find_or_create_by!(name: "Another App", icon: "http://placehold.it/48x48", client_id: "another123")
app.app_redirects.find_or_create_by!(uri: "http://localhost:8000/users")
AppSubscription.find_or_create_by!(user_id: user.id, app_id: app.id)

admin_role = Role.find_or_create_by!(name: "admin")
user.user_roles.find_or_create_by!(role_id: admin_role.id)
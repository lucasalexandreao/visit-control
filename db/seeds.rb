# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

admin1 = User.create!(
  email: "admin@example.com",
  password: "senha123",
  role: :admin
)

employee_user1 = User.create!(
  email: "funcionario1@example.com",
  password: "senha123",
  role: :employee
)

employee_user2 = User.create!(
  email: "funcionario2@example.com",
  password: "senha123",
  role: :employee
)

employee_user3 = User.create!(
  email: "funcionario3@example.com",
  password: "senha123",
  role: :employee
)

employee_user4 = User.create!(
  email: "funcionario4@example.com",
  password: "senha123",
  role: :employee
)

unit_a = Unit.create!(
  name: "Unidade A"
)

unit_b = Unit.create!(
  name: "Unidade B"
)

attendant1 = User.create!(
  email: "atendenteA@example.com",
  password: "senha123",
  role: :attendant,
  unit: unit_a
)

attendant2 = User.create!(
  email: "atendenteB@example.com",
  password: "senha123",
  role: :attendant,
  unit: unit_b
)

sector_a1 = Sector.create!(
  name: "Setor A1",
  unit: unit_a
)

sector_a2 = Sector.create!(
  name: "Setor A2",
  unit: unit_a
)

sector_b1 = Sector.create!(
  name: "Setor B1",
  unit: unit_b
)

sector_b2 = Sector.create!(
  name: "Setor B2",
  unit: unit_b
)

employee1 = Employee.create!(
  cpf: "111.111.111-11",
  name: "Funcionário A1",
  sector: sector_a1,
  user: employee_user1
)

employee2 = Employee.create!(
  cpf: "111.111.111-12",
  name: "Funcionário A2",
  sector: sector_a2,
  user: employee_user2
)

employee3 = Employee.create!(
  cpf: "111.111.111-13",
  name: "Funcionário B1",
  sector: sector_b1,
  user: employee_user3
)

employee4 = Employee.create!(
  cpf: "111.111.111-14",
  name: "Funcionário B2",
  sector: sector_b2,
  user: employee_user4
)

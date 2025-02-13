json.extract! employee, :id, :cpf, :name, :sector_id, :user_id, :created_at, :updated_at
json.url employee_url(employee, format: :json)

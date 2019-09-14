json.extract! customer, :id, :name, :balance, :lastmodified, :notes, :created_at, :updated_at
json.url customer_url(customer, format: :json)

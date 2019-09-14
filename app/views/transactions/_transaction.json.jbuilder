json.extract! transaction, :id, :amount, :note, :stamp, :customer_id, :created_at, :updated_at
json.url transaction_url(transaction, format: :json)

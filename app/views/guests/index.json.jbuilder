json.array!(@guests) do |guest|
  json.extract! guest, :first_name, :family_name, :email, :phone, :address, :postcode, :country, :retour, :registered_on
  json.url guest_url(guest, format: :json)
end

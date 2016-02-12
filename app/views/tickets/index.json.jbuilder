json.array!(@tickets) do |ticket|
  json.extract! ticket, :user_reclamatie, :data_reclamatie, :reclamatia, :obs, :status, :id_departament, :rezolvat, :in_lucru, :in_lucru_data, :rezolvat_operator, :rezolvat_data, :prioritate, :asignat_operator
  json.url ticket_url(ticket, format: :json)
end
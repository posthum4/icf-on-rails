json.array!(@attachments) do |attachment|
  json.extract! attachment, :id, :sfdcid, :name, :content_type, :body
  json.url attachment_url(attachment, format: :json)
end

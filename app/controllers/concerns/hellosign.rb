module Hellosign
  def client
    HelloSign::Client.new :api_key => ENV["HELLOSIGN_APIKEY"]
  end
  def create_template(params)
    client.create_embedded_template_draft(
      :test_mode => 1,
      :client_id => ENV["HELLOSIGN_CLIENTID"],
      :files => [params[:file_url]],
      :title => params[:title],
      :subject => 'Test Subject',
      :message => 'Test Message',
      :signer_roles => [
          {
              :name => 'Test Role',
              :order => 1
          },
          {
              :name => 'Test Role 2',
              :order => 2
          }
      ],
      :cc_roles => ['Test CC Role'],
      :merge_fields => '[{"name":"Test Merge","type":"text"},{"name":"Test Merge 2","type":"text"}]'
    )
  end
end
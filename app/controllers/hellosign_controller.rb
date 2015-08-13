require 'hello_sign'
class HellosignController < ApplicationController
  protect_from_forgery with: :null_session
  def callback
    
  end

  def create
    #create template
    client = HelloSign::Client.new :api_key => ENV["HELLOSIGN_APIKEY"]
    request = client.create_embedded_template_draft(
      :test_mode => 1,
      :client_id => ENV["HELLOSIGN_CLIENTID"],
      :files => ['/Users/juliolopez/Desktop/ruby-getting-started/public/pdf.pdf'],
      :title => 'Test Title',
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

    new_template_id = request.data['template_id']
    edit_url = request.data['edit_url']
    #is_embedded_draft = request.data['is_embedded_draft']
    Template.create(template_id: new_template_id, edit_url: edit_url)
  end

  def show
    #/template_id
    @template = Template.find_by_template_id(params[:id])
  end

end

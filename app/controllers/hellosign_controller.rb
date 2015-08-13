require 'hello_sign'
class HellosignController < ApplicationController
  protect_from_forgery with: :null_session
  def callback
    
  end

  def create
    #create template
    #puts params
    request = create_template(params.require(:hellosign)

    #request = client.create_embedded_template_draft(params.require(:hellosign))

    #is_embedded_draft = request.data['is_embedded_draft']
    Template.create(template_id: request.data['template_id'], edit_url: request.data['edit_url'])
  end

  def show
    #/template_id
    @template = Template.find_by_template_id(params[:id])
  end

end

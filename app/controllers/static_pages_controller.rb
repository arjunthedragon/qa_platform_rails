class StaticPagesController < ApplicationController
  layout 'static_page_layout'

  def home
  end


  def render_api_doc_pdf
    pdf_filename = File.join(Rails.root, "api_doc.pdf")
    send_file(pdf_filename, :filename => "api_doc.pdf", :disposition => 'inline', :type => "application/pdf")
  end
end
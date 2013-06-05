require 'wicked_pdf'
require 'wicked_pdf_tempfile'
WickedPdf.config = { :exe_path => '/usr/local/bin/wkhtmltopdf', :root_url => "http://localhost:3000" unless Rails.env.staging? || Rails.env.production? }

require 'wicked_pdf'
require 'wicked_pdf_tempfile'

if Rails.env == "development"
  WickedPdf.config = { :exe_path => '/usr/local/bin/wkhtmltopdf' }
end

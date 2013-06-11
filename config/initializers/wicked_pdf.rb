require 'wicked_pdf'
require 'wicked_pdf_tempfile'

if Rails.env == "development"
  WickedPdf.config = { :exe_path => Rails.root.join('app','bin','wkhtmltopdf') }
end

require 'wicked_pdf'
require 'wicked_pdf_tempfile'

WickedPdf.config = {
if Rails.env == "development"
  :exe_path => Rails.root.join('app','bin','wkhtmltopdf').to_s
else
  :exe_path => Rails.root.join('app','bin','wkhtmltopdf-amd64').to_s
  # exe_path = '/usr/local/bin/wkhtmltopdf'
end
}

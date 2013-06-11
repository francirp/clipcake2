require 'wicked_pdf'
require 'wicked_pdf_tempfile'
WickedPdf.config = { :exe_path => Rails.root.join('app','bin','wkhtmltopdf').to_s }

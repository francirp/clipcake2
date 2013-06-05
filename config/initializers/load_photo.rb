# load a Photo in development to prevent memcached
# undefined class/module error
if Rails.env == "development"
  p = Photo.new
end

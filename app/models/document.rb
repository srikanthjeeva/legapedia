class Document < ActiveRecord::Base
  
  has_attached_file :file,
                  :url  => "/assets/products/:id/:style/:basename.:extension",
                  :path => ":rails_root/public/assets/products/:id/:style/:basename.:extension"

  
  has_attached_file :file 
  validates_attachment :file, :content_type => { :content_type => %w(application/pdf) }

end

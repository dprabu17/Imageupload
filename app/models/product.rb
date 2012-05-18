class Product < ActiveRecord::Base
validates_attachment_presence :photo
attr_accessible :photo ,:image_uri,:title
has_attached_file :photo, :styles => { :normal => "100x100#", :small => ["70x70>", :jpg] }
end

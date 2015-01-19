class Address < ActiveRecord::Base
  belongs_to :customer

  enum area: { :huajing => "华景新城", :longwei => "龙威广场" }
end

class Artist < ActiveRecord::Base
  has_many :paintings
  has_many :galleries, through: :paintings

def self.create_artist(name)

  Artist.create({'name' => name})
end

end

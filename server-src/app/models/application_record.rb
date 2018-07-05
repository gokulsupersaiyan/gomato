class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def singular_name
    self.class.name.downcase.to_s
  end

  def to_json_response
    { singular_name => self }
  end
end

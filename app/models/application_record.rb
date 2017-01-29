# == Description
#
# Base class with common functionality for all models.
class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  # Compare strings by SQL like function.
  # Replace spaces by wildcard characters (%).
  def self.like(column = nil, text = nil)
    return self if text.blank? || column.blank?
    where(column + ' LIKE ?', "%#{text.split.join('%')}%")
  end
end

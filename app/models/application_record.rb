# == Description
#
# Base class with common functionality for all models.
class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  # Compare strings by SQL like function.
  # Replace spaces by wildcard characters (%).
  scope :like, -> (column = nil, text = nil) do
    return if text.blank? || column.blank?
    where(column + ' LIKE ?', "%#{text}%")
  end
end

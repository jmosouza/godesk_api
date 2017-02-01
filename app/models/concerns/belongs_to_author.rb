# = Description
#
# Common functionality to all models that have
# a +belongs_to+ relation to an author.
module BelongsToAuthor
  extend ActiveSupport::Concern
  included do
    ## :nodoc: Presentation

    # Return the username of the author by calling +author.username+.
    def author_username
      author.username
    end
  end
end

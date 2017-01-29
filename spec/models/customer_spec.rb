# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  username        :string(255)      not null
#  password_digest :string(255)      not null
#  type            :string(255)      not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

require 'rails_helper'
require 'support/shared_examples_for_user'

RSpec.describe Customer, type: :model do

  # see support/shared_examples_for_user
  include_examples 'user'

end

# == Description
#
# Subclass of User.
#
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

class Customer < User
end

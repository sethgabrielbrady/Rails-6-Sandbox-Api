class User < ApplicationRecord
  # has_secure_password
  devise :database_authenticatable, :registerable,
        :jwt_authenticatable, jwt_revocation_strategy: JwtDenylist
end

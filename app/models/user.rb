class User < ApplicationRecord

  has_secure_password
  enum role: { admin: 0, editor: 1, viewer: 2 }
  # Validations
  validates :username, presence: true, uniqueness: true
  validates :password,
            length: { minimum: 6 },
            if: -> { new_record? || !password.nil? }
  # Methods
  def admin?
    role == 'admin'
  end

  def editor?
    role == 'editor'
  end

  def viewer?
    role == 'viewer'
  end

end

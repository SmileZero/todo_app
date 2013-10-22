require 'digest/sha1'
class User < ActiveRecord::Base
  has_many :todos
  before_save :encrypt_password

  def encrypt_password
    if self.password_digest.present?
      self.password_digest = Digest::SHA1.hexdigest(self.password_digest)
    else
      self.password_digest = self.password_digest_was
    end
  end

  def registered?
  	new_user = User.find_by email:self.email
  	if new_user and new_user.password_digest == Digest::SHA1.hexdigest(self.password_digest)
  		self.id = new_user.id
  		return true
  	else
  		return false
  	end
  		
    # ここを考えて下さい。email/passwordで認証できれば true を認証できなければ falseを戻します。
    # さらに、認証できた場合はインスタンスのidに認証されたユーザーのidが入るようにします
  end
end
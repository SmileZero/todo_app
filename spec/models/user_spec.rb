require "spec_helper" 

describe User do
  fixtures :users

  describe "保存時に" do
    it "パスワードが与えられた場合は暗号化して格納する" do
      u = User.create(name:"abcde", email: "abcde@rails.com", password_digest: "test1")
      expect(u.password_digest).to eq("b444ac06613fc8d63795be9ad0beaf55011936ac")
    end
    it "パスワードが空文字列の場合はpasswordカラムは変更されない" do
      u = User.where(email: "yamada@rails.com").first
      u.update  password_digest: ""
      u2 = User.where(email: "yamada@rails.com").first
      expect(u2.password_digest).to eq("b444ac06613fc8d63795be9ad0beaf55011936ac")
    end
  end

  describe "registered?メソッド" do
    it "正しくないemailに対してはfalseを戻す" do
      u = User.new(email: "yama-da@rails.com", password_digest: "test1")
      expect(u.registered?).to be_false
    end

    it "正しくないpasswordに対してはfalseを戻す" do
      u = User.new(email: "yamada@rails.com",  password_digest: "test3")
      expect(u.registered?).to be_false
    end

    it "正しいemail/passwordに対してはtrueを戻す" do
      u = User.new(email: "yamada@rails.com",  password_digest: "test1")
      expect(u.registered?).to be_true
    end

    it "正しいemail/passwordで認証した時は認証者のidがセットされる" do
      u = User.new(email: "yamada@rails.com",  password_digest: "test1")
      u.registered?
      expect(u.id).to eq(users(:yamada).id)
    end
  end
end
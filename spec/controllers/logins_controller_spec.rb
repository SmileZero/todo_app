require "spec_helper" 

describe LoginsController do
  fixtures :users

  describe "newがGETされると" do
    before do
      get :new
    end
    it "newテンプレートが表示される" do
       expect(response).to render_template("new")
    end
    it "@userに空のUserインスタンスが設定されている" do
      expect(assigns(:user)).to be_a_new(User)
    end
  end

  describe "正しいemail/passwordがcreateにPOSTされると" do
    before do
      post :create, {:user=>{email: 'yamada@rails.com', password_digest: 'test1'}}
    end
    it "todosへリダイレクトする" do
      expect(response).to redirect_to(todos_path)
    end
    it "session[:login]にユーザーidがセットされる" do
      expect(session[:login]).to eq(users(:yamada).id)
    end
  end

  it "正しくないemail/passwordがcreateにPOSTされるとnewが表示される" do
    post :create, {:user=>{email: 'yamada@rails.com', password_digest: 'test0'}}
    expect(response).to render_template("new")
  end

  describe "destroyがDELETEされると" do
    before do
      delete :destroy, {id: users(:yamada).id}
    end
    it "session[:login]がnilになる"do
     # ここを考えて下さい
    end
    it "newへリダイレクトする" do
      # ここを考えて下さい
    end
  end

end
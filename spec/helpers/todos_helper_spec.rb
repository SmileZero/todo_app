require "spec_helper" 

describe TodosHelper do
  describe "newlineメソッドは" do
    it "改行を<br />タグに置き換える" do
      expect(helper.new_line("abc\nxyz\n123")).to eq("abc<br />xyz<br />123")
    end
    it "渡された文字列内のタグはエスケープする" do
      expect(helper. new_line("<table>\n")).to eq("&lt;table&gt;<br />")
    end
  end
end
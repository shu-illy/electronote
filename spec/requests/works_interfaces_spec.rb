require 'rails_helper'

RSpec.describe "IntegrationTest of WorksInterfaces", type: :request do
  
  let!(:test_user) { FactoryBot.create(:user) }
  let!(:other_user) { FactoryBot.create(:second_user) }  
  let!(:circuit_path) { File.join(Rails.root, 'spec/factories/test_image.png') }
  let!(:test_circuit) { Rack::Test::UploadedFile.new(circuit_path) }

  describe "Works interface" do
    
    before do
      40.times do |n|
        title  = "作品名#{n+1}"
        description = "作品説明#{n+1}"
        FactoryBot.create(:work, user: test_user )
        FactoryBot.create(:work, user: other_user )
      end
    end
    
    it "is valid" do
      # ログイン->新規投稿ページに移動
      log_in_as(test_user)
      get root_path
      expect(response.body).to match /<div[^>]*pagination[^>]*>/
      get new_work_path
      expect(response.body).to match /<input[^>]*type="file"[^>]*>/
      # 無効な内容を送信
      expect {
        post works_path, params: { work: { title: "" } }
      }.to change(Work, :count).by(0)
      expect(response.body).to match /<div[^>]*id="[^"]*error[^"]*"[^>]*>/
      expect(response).to render_template "works/new"
      # 有効な内容を送信
      test_title = "作品名テスト"
      # test_circuit = fixture_file_upload('spec/fixtures/test_image1.png', 'image/png')
      expect {
        post works_path, params: { work: { title: test_title, circuit: test_circuit } }
        # FactoryBot.create(:work, user: test_user)
      }.to change(Work, :count).by(1)
      expect(assigns(:work).circuit?).to be_truthy
      expect(response).to redirect_to root_path
      follow_redirect!
      expect(response.body).to match /#{test_title}/
      # 投稿削除
      expect(response.body).to match /<a[^>]*>削除<\/a>/
      first_work = test_user.works.paginate(page: 1).first
      expect {
        delete work_path(first_work)
      }.to change(Work, :count).by(-1)
      get user_path(other_user)
      expect(response.body).not_to match /<a[^>]*>削除<\/a>/
    end
  end

end

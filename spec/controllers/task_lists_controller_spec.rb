require 'rails_helper'

RSpec.describe TaskListsController, :type => :controller do

  describe "GET 'edit'" do
    it "returns http success" do
      get 'edit'
      expect(response).to be_success
    end
  end

  describe "GET 'destroy'" do
    it "returns http success" do
      get 'destroy'
      expect(response).to be_success
    end
  end

end

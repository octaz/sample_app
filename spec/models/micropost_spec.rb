require 'spec_helper'

describe Micropost do
  let (:user) {FactoryGirl.create(:user)}

  before do
  	#this colde is not idiomatically correct
  	#@micropost = Micropost.new(content: "Lux Ipse", user_id: user.id)
  	@micropost = user.microposts.build(content: "Lux Ipse")
  end

  subject {@micropost}

  it {should respond_to(:content)}
  it {should respond_to(:user_id)}
  it {should respond_to(:user)}
  its(:user) {should eq user}

  it {should be_valid}

  describe "when a user id is not present" do
  	before {@micropost.user_id = nil}
  	it {should_not be_valid}
  end

  describe "when content is empty" do
  	before {@micropost.content = ""}
  	it {should_not be_valid}
  end

end

require "test_helper"

describe UsersController do
  describe "index" do
    it "should get index" do
      get users_path

      must_respond_with :success
    end
  end

  describe "show" do
    it "should be OK to show an existing, valid user" do
      valid_user_id = users(:one).id

      get user_path(valid_user_id)

      must_respond_with :success
    end

    it "should give a flash notice instead of showing a non-existant, invalid user" do
      user = users(:one)
      invalid_user_id = user.id
      user.destroy

      get user_path(invalid_user_id)

      must_respond_with :redirect
      expect(flash[:error]).must_equal "Unknown user"
    end
  end

  describe "create" do
    it "will save a new user and redirect if given valid inputs" do
      input_username = "MyFirstUsername"
      test_input = {
        "user": {
          username: input_username,
        },
      }

      expect {
        post users_path, params: test_input
      }.must_change "User.count", 1

      new_user = User.find_by(username: input_username)
      expect(new_user).wont_be_nil
      expect(new_user.username).must_equal input_username

      must_respond_with :redirect
    end
  end
end

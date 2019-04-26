require "test_helper"

describe WorksController do
  describe "index" do
    it "should get index" do
      get works_path

      must_respond_with :success
    end
  end

  describe "show" do
    it "should be OK to show an existing, valid work" do
      valid_work_id = works(:holes).id

      get work_path(valid_work_id)

      must_respond_with :success
    end

    it "should give a flash notice instead of showing a non-existant, invalid work" do
      work = works(:holes)
      invalid_work_id = work.id
      work.destroy

      get work_path(invalid_work_id)

      must_respond_with :redirect
      expect(flash[:error]).must_equal "Unknown work"
    end
  end
end

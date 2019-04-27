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

  describe "create" do
    it "will save a new work and redirect if given valid inputs" do
      input_category = "book"
      input_title = "Practical Object Oriented Programming in Ruby"
      input_creator = "Sandi Metz"
      input_publication_year = 2006
      input_description = "A look at how to design object-oriented systems"
      test_input = {
        "work": {
          category: input_category,
          title: input_title,
          creator: input_creator,
          publication_year: input_publication_year,
          description: input_description,
        },
      }

      expect {
        post works_path, params: test_input
      }.must_change "Work.count", 1

      # Assert
      new_work = Work.find_by(title: input_title)
      expect(new_work).wont_be_nil
      expect(new_work.category).must_equal input_category
      expect(new_work.title).must_equal input_title
      expect(new_work.creator).must_equal input_creator
      expect(new_work.publication_year).must_equal input_publication_year
      expect(new_work.description).must_equal input_description

      must_respond_with :redirect
    end
  end
end

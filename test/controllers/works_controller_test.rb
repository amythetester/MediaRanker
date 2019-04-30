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

  describe "update" do
    it "will update an existing work" do
      work_to_update = works(:holes)

      input_title = "101 Spotted Puppies"
      input_description = "Crazy person gets their just desserts"
      test_input = {
        "work": {
          title: input_title,
          description: input_description,
        },
      }

      expect {
        patch work_path(work_to_update.id), params: test_input
      }.wont_change "Work.count"

      must_respond_with :redirect
      work_to_update.reload
      expect(work_to_update.title).must_equal test_input[:work][:title]
      expect(work_to_update.description).must_equal test_input[:work][:description]
    end

    it "will return a bad_request (400) when asked to update with invalid data" do
      work_to_update = works(:holes)

      input_title = "" # Invalid Title
      input_description = "The best movie"
      test_input = {
        "work": {
          title: input_title,
          description: input_description,
        },
      }

      expect {
        patch work_path(work_to_update.id), params: test_input
      }.wont_change "Work.count"

      must_respond_with :bad_request
      work_to_update.reload
      expect(work_to_update.title).must_equal works(:holes).title
      expect(work_to_update.description).must_equal works(:holes).description
    end
  end

  describe "destroy" do
    it "can delete a work" do
      new_work = Work.create(title: "The Martian", category: "movie", publication_year: 2017, creator: "Some Person", description: "stuff happens")

      expect {
        delete work_path(new_work.id)
      }.must_change "Work.count", -1

      must_respond_with :redirect
      must_redirect_to works_path
    end
  end
end

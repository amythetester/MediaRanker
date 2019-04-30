require "test_helper"

describe Work do
  let(:work) {
    Work.new(
      category: "movie",
      title: "The Fox and the Hound",
      creator: "Disney",
      publication_year: 1990,
      description: "Destined enemies become unlikely friends",
    )
  }

  it "must be valid" do
    value(work).must_be :valid?
  end
end

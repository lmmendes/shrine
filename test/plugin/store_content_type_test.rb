require "test_helper"
require "mime/types/columnar"

class StoreContentTypeTest < Minitest::Test
  def setup
    @uploader = uploader(:bare) { plugin :store_content_type }
  end

  test "content type gets stored into metadata" do
    uploaded_file = @uploader.upload(fakeio(content_type: "image/jpeg"))

    assert_equal "image/jpeg", uploaded_file.metadata["content_type"]
  end

  test "determining content type with mime-types" do
    uploaded_file = @uploader.upload(fakeio(filename: "avatar.png"))

    assert_equal "image/png", uploaded_file.metadata["content_type"]
  end

  test "content type doesn't get stored when it's unkown" do
    uploaded_file = @uploader.upload(fakeio)
    assert_equal nil, uploaded_file.metadata["content_type"]

    uploaded_file = @uploader.upload(fakeio(filename: "avatar.foo"))
    assert_equal nil, uploaded_file.metadata["content_type"]
  end

  test "UploadedFile gets `content_type` method" do
    uploaded_file = @uploader.upload(fakeio(content_type: "image/jpeg"))

    assert_equal "image/jpeg", uploaded_file.content_type
  end
end
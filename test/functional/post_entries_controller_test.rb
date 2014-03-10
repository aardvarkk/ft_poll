require 'test_helper'

class PostEntriesControllerTest < ActionController::TestCase
  setup do
    @post_entry = post_entries(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:post_entries)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create post_entry" do
    assert_difference('PostEntry.count') do
      post :create, post_entry: { author_id: @post_entry.author_id, content: @post_entry.content }
    end

    assert_redirected_to post_entry_path(assigns(:post_entry))
  end

  test "should show post_entry" do
    get :show, id: @post_entry
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @post_entry
    assert_response :success
  end

  test "should update post_entry" do
    put :update, id: @post_entry, post_entry: { author_id: @post_entry.author_id, content: @post_entry.content }
    assert_redirected_to post_entry_path(assigns(:post_entry))
  end

  test "should destroy post_entry" do
    assert_difference('PostEntry.count', -1) do
      delete :destroy, id: @post_entry
    end

    assert_redirected_to post_entries_path
  end
end

require 'test_helper'

class WeddingControllerTest < ActionController::TestCase
  test "should get home" do
    get :home
    assert_response :success
  end

  test "should get story" do
    get :story
    assert_response :success
  end

  test "should get photos" do
    get :photos
    assert_response :success
  end

  test "should get program" do
    get :program
    assert_response :success
  end

  test "should get rsvp" do
    get :rsvp
    assert_response :success
  end

  test "should get transports" do
    get :transports
    assert_response :success
  end

  test "should get stay" do
    get :stay
    assert_response :success
  end

  test "should get area" do
    get :area
    assert_response :success
  end

  test "should get gifts" do
    get :gifts
    assert_response :success
  end

  test "should get contact" do
    get :contact
    assert_response :success
  end

end

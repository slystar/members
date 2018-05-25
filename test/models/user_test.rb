require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user=User.new(name:"test",admin:true, password: "123456789", password_confirmation: "123456789")
  end

  test "should be valid" do
    assert @user.valid?
  end

  test "name should be present" do
    @user.name=nil
    assert_not @user.valid?
    @user.name=""
    assert_not @user.valid?
  end

  test "name should not be too long" do
    @user.name="a" * 51
    assert_not @user.valid?
  end

  test "user should be unique" do
    dup_user=@user.dup
    @user.save
    assert_not dup_user.valid?
  end

  test "password should be present (nonblank)" do
    @user.password = @user.password_confirmation = " " * 6
    assert_not @user.valid?
  end

  test "password should have a minimum length" do
    @user.password = @user.password_confirmation = "a" * 5
    assert_not @user.valid?
  end
end

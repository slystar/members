require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user=get_next_user
  end

  def get_next_user
    @user_id = @user_id.to_i + 1
    User.new(name:"test#{@user_id}", password: "123456789", password_confirmation: "123456789")
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
    @user.password = @user.password_confirmation = "a" * 7
    assert_not @user.valid?
    @user.password = @user.password_confirmation = "a" * 8
    assert @user.valid?
  end

  test "default admin should be false" do
    assert_not @user.admin
  end

  test "the first user should be admin" do
    User.destroy_all
    assert User.all.size == 0
    @user.save
    assert @user.admin
    u2=get_next_user
    assert u2.save
    assert_not u2.admin
  end

end

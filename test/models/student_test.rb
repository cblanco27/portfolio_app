require "test_helper"

class StudentTest < ActiveSupport::TestCase
  test "first name cannot be blank" do
    student = Student.new(first_name: " ", last_name: "White", school_email: "cwhite72@msudenver.edu", major: "Psychology", minor: "CS", graduation_date: 2024/12/13)
    assert_not student.save
    assert_includes student.errors[:first_name], "can't be blank"
  end

  test "can create a user" do
    student = Student.new(first_name: "Chase", last_name: "White", school_email: "cwhite72@msudenver.edu", major: "Psychology", minor: "CS", graduation_date: 2024/12/13)
    assert student.save
  end

  test "last name cannot be blank" do 
    student = Student.new(first_name: "Chase", last_name: " ", school_email: "cwhite72@msudenver.edu", major: "Psychology", minor: "CS", graduation_date: 2024/12/13)
    assert_not student.save
    assert_includes student.errors[:last_name], "can't be blank"
  end

  test "school email cannot be blank" do 
    student = Student.new(first_name: "Chase", last_name: "White", school_email: " ", major: "Psychology", minor: "CS", graduation_date: 2024/12/13)
    assert_not student.save
    assert_includes student.errors[:school_email], "can't be blank"
  end

  test "school email must be valid email" do
    student = Student.new(first_name: "Chase", last_name: "White", school_email: "cwhite72nv;oainse", major: "Psychology", minor: "CS", graduation_date: 2024/12/13)
    assert_not student.save
    assert_includes student.errors[:school_email], "is invalid"
  end

  test "must have graduation date" do
    student = Student.new(first_name: "Chase", last_name: "White", school_email: "cwhite72@msudenver.edu", major: "Psychology", minor: "CS", graduation_date: nil )
    assert_not student.save
    assert_includes student.errors[:graduation_date], "can't be blank"
  end

  test "create student without minor" do 
    student = Student.new(first_name: "Chase", last_name: "White", school_email: "cwhite72@msudenver.edu", major: "Psychology", minor: " ", graduation_date: 2024/12/13)
    assert student.save
  end

  test "major must not be blank" do
    student = Student.new(first_name: "Chase", last_name: "White", school_email: "cwhite72@msudenver.edu", major: " ", minor: "CS", graduation_date: 2024/12/13)
    assert_not student.save
    assert_includes student.errors[:major], "can't be blank"
  end
end

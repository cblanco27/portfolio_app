require 'rails_helper'
 
#request specs for the Students resource focusing on HTTP requests
RSpec.describe "Students", type: :request do

  # GET /students (index)
  describe "GET /students" do
    context "when students exist" do
      let!(:student) { Student.create!(first_name: "Aaron", last_name: "Gordon", school_email: "gordon@msudenver.edu", major: "Computer Science BS", graduation_date: "2025-05-15") }

      # Test 1: Returns a successful response and displays the search form
      it "returns a successful response and displays the search form" do
        get students_path
        expect(response).to have_http_status(:ok)
        expect(response.body).to include('Search') # Ensure search form is rendered
      end

      # Test 2: Ensure it does NOT display students without a search
      it "does not display students until a search is performed" do
        get students_path
        expect(response.body).to_not include("Aaron")
      end
    end

    # Test 3: Handle missing records or no search criteria provided
    context "when no students exist or no search is performed" do
      it "displays a message prompting to search" do
        get students_path
        expect(response.body).to_not include("Aaron")
      end
    end
  end

  # Search functionality
  describe "GET /students (search functionality)" do
    let!(:student1) { Student.create!(first_name: "Aaron", last_name: "Gordon", school_email: "gordon@msudenver.edu", major: "Computer Science BS", graduation_date: "2025-05-15") }
    let!(:student2) { Student.create!(first_name: "Jackie", last_name: "Joyner", school_email: "joyner@msudenver.edu", major: "Data Science and Machine Learning Major", graduation_date: "2026-05-15") }

    # Test 4: Search by major
    it "returns students matching the major" do
      get students_path, params: { search: { major: "Computer Science BS" } }
      expect(response.body).to include("Aaron")
      expect(response.body).to_not include("Jackie")
    end

    # Test 5: Search by expected graduation date (before)
    it "returns correct student(s) graduating before the given date" do
      get students_path, params: { search: { expected_graduation_date: "2026-01-01", graduation_date_select: "Before" } }
      expect(response.body).to include("Aaron")
      expect(response.body).to_not include("Jackie")
    end

    # Test 6: Search by expected graduation date (after)
    it 'returns the correct student(s) when searched given a date - after' do
      get students_path, params: { search: { expected_graduation_date: '2026-01-01', graduation_date_select: 'After' } }
      expect(response.body).to include('Jackie')
      expect(response.body).to_not include('Aaron')
    end

  end

  # POST /students (create)
  describe "POST /students" do
    context "with valid parameters" do
      # Test 7: Create a new student and ensure it redirects
      it "creates a new student and redirects" do
        expect {
          post students_path, params: { student: { first_name: "Aaron", last_name: "Gordon", school_email: "gordon@msudenver.edu", major: "Computer Science BS", graduation_date: "2025-05-15" } }
        }.to change(Student, :count).by(1)

        expect(response).to have_http_status(:found)  # Expect redirect after creation
        follow_redirect!
        expect(response.body).to include("Aaron")  # Student's details in the response
      end

      # Test 8 
      it "creates a new student and redirects" do
        expect {
          post students_path, params: { student: { first_name: "Aaron", last_name: "Gordon", school_email: "gordon@msudenver.edu", major: "Computer Science BS", graduation_date: "2025-05-15" } }
        }.to change(Student, :count).by(1)

        expect(response).to have_http_status(:found)
        follow_redirect!
        expect(response.body).to include('Student was successfully created.')
        expect(response.body).to include('Aaron')
      end
      # Ensure that it checks for creation success 
    end

    context "with invalid parameters" do
      # Test 9 (Student will complete this part)
      it "does not create a student when given invalid parameters" do
        expect {
          post students_path, params: { student: { first_name: "Aaron", last_name: "Gordon", school_email: "", major: "Computer Science BS", graduation_date: "2025-05-15" } }
        }.to change(Student, :count).by(0)

        expect(response).to_not be_successful
        expect(response.status).to eq(422)
      end
      # Ensure it does not create a student and returns a 422 status
    end
  end

  # GET /students/:id (show)
  describe "GET /students/:id" do
    context "when the student exists" do
      let!(:student) { Student.create!(first_name: "Aaron", last_name: "Gordon", school_email: "gordon@msudenver.edu", major: "Computer Science BS", graduation_date: "2025-05-15") }

      # Test 10 (Student will complete this part)
      it "returns a student's details" do
        get student_path(id: student.id)
        expect(response).to be_successful
        expect(response.status).to eq(200)
        #changed to singular to allow it to access the student.show page instead of the index page
      end
      # Ensure it returns a successful response (200 OK)

      # Test 11 (Student will complete this part)
      it "have correct student details in response body" do
        get student_path(id: student.id)
        
      expect(response.body).to include("Aaron")
      expect(response.body).to include("Gordon")
      expect(response.body).to include("gordon@msudenver.edu")
      expect(response.body).to include("Computer Science BS")
      expect(response.body).to include("2025-05-15")
      end
      # Ensure it includes the student's details in the response body
    end

    # Test 12: Handle missing records
    it "will not return a non-existent student" do
      get student_path(id: -1)
      expect(response).to_not be_successful
      expect(response.status).to eq(404)
    end

  end

  # DELETE /students/:id (destroy)
  describe "DELETE /students/:id" do
    let!(:student) { Student.create!(first_name: "Aaron", last_name: "Gordon", school_email: "gordon@msudenver.edu", major: "Computer Science BS", graduation_date: "2025-05-15") }

    # Test 13: Deletes the student and redirects
    it "deletes a student and successfully redirects" do
      delete student_path(id: 1)
      expect(Student.count).to eq(0)
      follow_redirect!
      #to follow the redirect to make sure response was made to check for deletion.
      expect(response.body).to include("Student was successfully destroyed.")
    end


    # Test 14: Returns a 404 when trying to delete a non-existent student
    it "returns a 404 status when trying to delete a non-existent student" do
      delete "/students/9999"
      expect(response).to have_http_status(:not_found)
    end
  end
end
require "test_helper"

describe CustomersController do
  KEYS = %w(id movies_checked_out_count name phone postal_code registered_at)

  describe "index" do
    it "is a real working route" do
      get customers_path
      must_respond_with :success
    end

    it "returns a json" do
      get customers_path
      response.header['Content-Type'].must_include 'json'
    end

    it "returns an array" do
      get customers_path
      body = JSON.parse(response.body)
      body.must_be_kind_of Array
    end

    it "returns all the customers" do
      get customers_path
      body = JSON.parse(response.body)
      body.length.must_equal Customer.count
    end

    it "returns customers with exactly the required fields" do
      get customers_path
      must_respond_with :success
      body = JSON.parse(response.body)
      body.each do |customer|
        customer.keys.sort.must_equal KEYS
      end
    end

    it "returns an empty array if no customers" do
      Customer.delete_all
      get customers_path
      must_respond_with :success
      body = JSON.parse(response.body)
      body.must_equal []
    end
  end
end

require 'rails_helper'

RSpec.describe 'Items API', type: :request  do
  # Initialize the test data
  let!(:items) { create_list(:item, 20) }
  let(:id) { items.first.id }
  
  
  # Test suite for GET /todos/:todo_id/items
  describe 'GET /items' do
    before { get "/items" }

    context 'when items exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns all  items' do
        expect(json.size).to eq(20)
      end
    end

  end

  # Test suite for GET /items/:id
  describe 'GET /items/:id' do
    before { get "/items/#{id}" }

    context 'when Item exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
        #puts JSON.parse(response.body) 
      end

      it 'returns the item' do
        item = JSON.parse(response.body) 
        expect(item.keys).to contain_exactly( 
        'id',
        'description',
        'price',
        'stockQty',
        'created_at',
        'updated_at')
      end
    end

    context 'when item does not exist' do
      let(:id) { 200 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

    end
  end
  

  # Test suite for PUT /items
  describe 'POST /items' do
    let(:valid_attributes) { { description: 'Visit Narnia', price: "999.99",stockQty:"10"  } }

    context 'when request attributes are valid' do
      before { post "/items", params: valid_attributes }

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when an invalid request' do
      before { post "/items", params: {} }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a failure message' do
        expect(response.body).to match(/Validation failed: Description can't be blank/)
      end
    end
  end

  # Test suite for PUT /items/:id
  describe 'PUT /items/:id' do
    let(:valid_attributes) { { description: 'Visit Narnia', price: "999.99",stockQty:"10"  } }

    before { put "/items/#{id}", params: valid_attributes }

    context 'when item exists' do
      it 'returns status code 204' do
      #puts JSON.parse(response.body) 
      end

      it 'updates the item' do
        updated_item = Item.find(id)
        expect(updated_item.description).to match(/Visit Narnia/)
      end
    end

    context 'when the item does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Item/)
      end
    end
  end

  # Test suite for PUT /items/:id
  describe 'PUT /items/order' do
    let(:valid_attributes) { { itemId: id, description: "For the Hord",customerId:"10",price: "999.99",award:"0.0",total: "999.99"  } }
    #let(:item) {Item.find(id)}

    context 'when item exists' do

      it 'returns status code 204' do
        get "/items/#{id}"
        item  = JSON.parse(response.body)
        put '/items/order', params: valid_attributes
        #puts valid_attributes 
        #puts JSON.parse(response.body) 
        expect(response).to have_http_status(204)
        get "/items/#{id}"
        itemNew  = JSON.parse(response.body)
        expect(itemNew['stockQty']).to be < item['stockQty']
      end

    end

  end


end
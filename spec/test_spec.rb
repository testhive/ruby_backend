require 'net/http'
require 'json'

class PetStore
  def create_pet pet_id
    url = 'https://petstore.swagger.io/v2/pet'

    body_hash = {
        'id': pet_id,
        'category': {
            'id': Time.now.to_i,
            'name': 'dog'
        },
        'name': 'punchy',
        'status': 'available'
    }

    uri = URI(url)
    post_req = Net::HTTP::Post.new(uri, 'Content-Type': 'application/json', 'Accept': 'application/json')
    post_req.body = body_hash.to_json
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    http.request(post_req)
  end

  def retrieve_pet id
    url = 'https://petstore.swagger.io/v2/pet'
    uri = URI(url + "/#{id}")
    get_req = Net::HTTP::Get.new(uri, 'Accept': 'application/json')
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    http.request(get_req)
  end
end


RSpec.describe PetStore do
  context 'When testing petstore API' do
    pet_id = Time.now.to_i

    it 'Creates a pet on swagger' do
      ps = PetStore.new
      post_res = ps.create_pet pet_id
      expect(post_res.code.to_i).to eq 200
      puts post_res
    end
    it 'Retrieves pet details on swagger' do
      ps = PetStore.new
      get_res = ps.retrieve_pet pet_id

      expect(get_res.code.to_i).to eq 200
      puts get_res.body
    end
  end
end
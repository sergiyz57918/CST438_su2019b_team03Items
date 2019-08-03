require 'httparty'

class ItemClient 
  include HTTParty
  
  base_uri "http://localhost:8080"
	format :json

  def self.getItem(id)
    get "/items?id=#{id}" 
  end
  
  def self.createItem(item) 
    post '/items', body: item.to_json, 
         headers:  { 'Content-Type' => 'application/json', 'ACCEPT' => 'application/json' }
  end 
  
    def self.updateItem(item)
     put "/items?id=#{item[:id]}", body: item.to_json, 
         headers:  { 'Content-Type' => 'application/json', 'ACCEPT' => 'application/json' }
  end
  
end 

while true 
  puts "What do you want to do: create, update, get or quit"
  userInput = gets.chomp!
  puts  
  if userInput == 'quit'
      break
  elsif userInput == 'get'
      puts 'enter id of item to lookup'
      id = gets.chomp!
      response = ItemClient.getItem(id)
      puts "status code #{response.code}"
      puts response.body 
      puts
  elsif userInput == 'create'
      puts 'enter item description'
      description = gets.chomp!
      puts 'enter item price'
      price = gets.chomp!
      puts 'enter item stockQty'
      stockQty = gets.chomp!
      response = ItemClient.createItem(description: description, price: price, stockQty: stockQty)
      puts "status code #{response.code}"
      puts response.body 
      puts 
  elsif userInput == 'update'
      puts 'enter id of item to update'
      id = gets.chomp!
      puts 'enter  description'
      description = gets.chomp!
      puts 'enter  price'
      price = gets.chomp!
      puts 'enter  stockQty'
      stockQty = gets.chomp!
      response = ItemClient.updateItem(id: id, description: description, price: price, stockQty: stockQty)
      puts "status code #{response.code}"
      puts response.body 
      puts 
  else 
    puts "Not valid input."
  end 
end 
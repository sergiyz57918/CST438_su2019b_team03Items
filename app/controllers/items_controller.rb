class ItemsController < ApplicationController
    
    def index
    json_response(Item.all)
    end
    
    def create
        Item.create!(item_params)
        json_response(@item, :created)
    end
    
    def show 
        @item = Item.find(params[:id])
        if @item
            json_response(@item, :ok)
        else
            json_response(@item,:not_found)
        end
    end
    
    def update
        @item = Item.find(params[:id])
        @item.update(item_params)
        #json_response(@item,:no_content)
        head :no_content
    end
    
    def order
        @item = Item.find(params[:itemId])
        if @item
            if @item.stockQty>0
                qty = @item.stockQty
                @item.stockQty=qty-1 
                if @item.save
                    head :no_content
                else
                    json_response({message: 'Oops Not Found: '+params[:itemId]},:bad_request)
                end
            else
                json_response({message: 'Oops stockQty: ' + @item.stockQty.to_s},:bad_request)
            end
        else
            json_response({message: 'Oops Not Found'},:not_found)
        end
    
    end
    
    private
    
    def item_params
        params.permit(:description,:price,:stockQty)
    end
    
    def order_params
        params.permit(:itemId,:description,:customerId,:price,:award,:total)
    end
    

end

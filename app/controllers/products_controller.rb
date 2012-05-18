class ProductsController < ApplicationController
  # GET /products
  # GET /products.json
  def index
    @products = Product.all
	puts "&&&&&&&&&&&&&&&&&&&&"
	puts @products.inspect
	
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @products }
    end
  end

  # GET /products/1
  # GET /products/1.json
  def show
    @product = Product.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @product }
    end
  end

  # GET /products/new
  # GET /products/new.json
  def new
    @product = Product.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @product }
    end
  end

  # GET /products/1/edit
  def edit
    @product = Product.find(params[:id])
  end

  # POST /products
  # POST /products.json
  def create
  begin
  puts "Create"
  puts "**************************************"
  puts params.inspect
  puts "**************************************"
  
    if params[:photo] and params[:photo]!=nil
	  @product = Product.new
	  #url = URI.parse(URI.encode(params["photo"]))
	  @product.update_attribute(:photo,File.open(params["photo"], "r"))
	  @product.update_attribute(:image_uri , "http://192.168.1.12:3000"+ @product.photo.url)
	  puts @product.inspect
	  puts "&&&&&&&&&&&&"
	else
		@product = Product.new(params[:product])
	end
	
    respond_to do |format|
      if @product.save 
        @product.update_attribute(:image_uri , "http://192.168.1.12:3000"+ @product.photo.url) 	 unless params[:photo] and params[:photo]!=nil 
        format.html { redirect_to @product, notice: 'Product was successfully created.' }
        format.json { render json: @product, status: :created, location: @product }
      else
        format.html { render action: "new" }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
	rescue Exception => e
	puts e
	end
  end

  # PUT /products/1
  # PUT /products/1.json
  def update
    @product = Product.find(params[:id])

    respond_to do |format|
      if @product.update_attributes(params[:product])
        format.html { redirect_to @product, notice: 'Product was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1
  # DELETE /products/1.json
  def destroy
    @product = Product.find(params[:id])
    @product.destroy

    respond_to do |format|
      format.html { redirect_to products_url }
      format.json { head :ok }
    end
  end
end

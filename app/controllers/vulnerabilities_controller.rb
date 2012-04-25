class VulnerabilitiesController < ApplicationController
  def index
    @vulnerabilities = Vulnerability.all
  end

  def show
    @vulnerability = Vulnerability.find(params[:id])
    @page = params[:page].to_i > 0 ? params[:page].to_i : 1
    @pages = (@vulnerability.messages.count / 1000.0).ceil
    @pages = 1 if @pages == 0
    @page = 1 if @page > @pages
    @messages = @vulnerability.messages.limit(1000).offset((@page - 1) * 1000)
  end

  def new
    @vulnerability = Vulnerability.new
  end

  def edit
    @vulnerability = Vulnerability.find(params[:id])
  end

  def create
    @vulnerability = Vulnerability.new(params[:vulnerability])

    if @vulnerability.save
      redirect_to vulnerabilities_path, notice: 'Vulnerability was successfully created.'
    else
      render action: "new"
    end
  end
  
  def update
    @vulnerability = Vulnerability.find(params[:id])

    if @vulnerability.update_attributes(params[:vulnerability])
      redirect_to vulnerabilities_path, notice: 'Vulnerability was successfully updated.'
    else
      render action: "edit"
    end
  end
  
  def clear
    Message.destroy_all(:vulnerability_id => params[:id])
    redirect_to vulnerabilities_path
  end

  def destroy
    @vulnerability = Vulnerability.find(params[:id])
    @vulnerability.destroy

    redirect_to vulnerabilities_url
  end
end

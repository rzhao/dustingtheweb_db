class VulnerabilitiesController < ApplicationController
  def index
    @vulnerabilities = Vulnerability.all
  end

  def show
    @vulnerability = Vulnerability.find(params[:id])
    @messages = @vulnerability.messages
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
      redirect_to @vulnerability, notice: 'Vulnerability was successfully updated.'
    else
      render action: "edit"
    end
  end

  def destroy
    @vulnerability = Vulnerability.find(params[:id])
    @vulnerability.destroy

    redirect_to vulnerabilities_url
  end
end

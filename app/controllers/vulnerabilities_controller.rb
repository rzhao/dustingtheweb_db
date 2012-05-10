class VulnerabilitiesController < ApplicationController
  def index
    @vulnerabilities = Vulnerability.all
    
    # HARD-CODED STATS:
    @cookies1 = Message.find_all_by_vulnerability_id(31).select { |m| !m.crawler && m.text == "Secure website set a non-secure cookie!" }
    @cookies2 = Message.find_all_by_vulnerability_id(31).select { |m| !m.crawler && m.text == "Non-secure website set a secure cookie!" }
  end

  def show
    @vulnerability = Vulnerability.find(params[:id])
    @page = params[:page].to_i > 0 ? params[:page].to_i : 1
    @pages = (@vulnerability.messages.count / 500.0).ceil
    @pages = 1 if @pages == 0
    @page = 1 if @page > @pages
    @messages = @vulnerability.messages.limit(500).offset((@page - 1) * 500)
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

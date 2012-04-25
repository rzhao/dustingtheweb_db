class MessagesController < ApplicationController
  def index
    @messages = Message.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @messages }
    end
  end
  
  def create
    vid = params[:message][:vulnerability_id]
    if vid.to_i == 0
      vid = Vulnerability.find_by_name(vid).id rescue nil
    end

    params[:message][:vulnerability_id] = vid unless vid.nil?
    @message = Message.find_by_url_and_vulnerability_id_and_text(params[:message][:url], params[:message][:vulnerability_id], params[:message][:text])
    if @message.nil?
      @message = Message.new(params[:message]) 
    else
      @message.count = @message.count + 1
    end

    respond_to do |format|
      if vid.nil?
        format.json { render json: "Error: Improper vulnerability_id", status: :unprocessable_entity }
      elsif @message.save
        format.json { render json: @message, status: :created, location: @message }
      else
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def dump
    respond_to do |format|
      format.json { render json: Message.all.to_json }
    end
  end

  def destroy
    @message = Message.find(params[:id])
    @message.destroy

    respond_to do |format|
      format.html { redirect_to messages_url }
      format.json { head :ok }
    end
  end
end

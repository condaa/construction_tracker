class TicketsController < ApplicationController
  def index
    @tickets = current_user.tickets.paginate(page: params[:page], per_page: 10)
    render json: @tickets
  end

  def show
    @ticket = current_user.tickets.find(params[:id])
    render json: @ticket
  end

  def create
    @ticket = current_user.tickets.create(ticket_params)
    if @ticket.valid?
      render json: @ticket, status: :created
    else
      render json: { errors: @ticket.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    @ticket = current_user.tickets.find(params[:id])
    if @ticket.update(ticket_params)
      render json: @ticket
    else
      render json: { errors: @ticket.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @ticket = current_user.tickets.find(params[:id])
    @ticket.destroy
    head :no_content
  end

  private

  def ticket_params
    params.require(:ticket).permit(:title, :description, :assigned_user_id, :due_date, :status_id, :progress).tap{ |wl|
      wl[:status_id] = wl[:status_id].to_i
    }
  end

  def per_page
    12
  end
end

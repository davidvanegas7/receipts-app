class ReceiptsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_receipt, only: [:show, :edit, :update, :destroy]
    before_action :check_owner, only: [:show, :edit, :update, :destroy]

    def index
      @receipts = current_user.receipts.order('created_at DESC')
    end

    def show
    end

    def new
      @receipt = current_user.receipts.new
    end

    def create
      @receipt = current_user.receipts.new(receipt_params)
      @receipt.current_user_id = current_user.id

      if @receipt.save
        redirect_to @receipt, notice: 'Receipt was successfully created.'
      else
        render :new
      end
    end

    def edit
    end

    def update
      @receipt.current_user_id = current_user.id

      if @receipt.update(receipt_params)
        redirect_to @receipt, notice: 'Receipt was successfully updated.'
      else
        render :edit
      end
    end

    def destroy
      @receipt.destroy
      redirect_to receipts_url, notice: 'Receipt was successfully destroyed.'
    end

    private
      def set_receipt
        @receipt = Receipt.find(params[:id])
      end

      def receipt_params
        params.require(:receipt).permit(:image)
      end

      def check_owner
        unless @receipt.user == current_user
          redirect_to root_path, notice: 'You are not authorized to see this receipt.'
        end
      end
end

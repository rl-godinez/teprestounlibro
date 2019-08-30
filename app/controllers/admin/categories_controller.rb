# frozen_string_literal: true

module Admin
  class CategoriesController < Admin::ApplicationController
    before_action :set_category, only: %i[show edit update destroy]

    def new
      @category = Category.new
    end

    def edit; end

    def update
      if @category.update(secure_params)
        flash[:success] = 'Category successfully updated'
        redirect_to admin_categories_url
      else
        flash.now[:danger] = @category.errors.full_messages.to_sentence
        render :edit
      end
    end

    def create
      @category = Category.new secure_params

      if @category.save
        flash[:notice] = 'Category was successfully created'
        redirect_to admin_categories_url
      else
        flash.now[:danger] = @category.errors.full_messages.to_sentence
        render :new
      end
    end

    def destroy
      @category.destroy
      redirect_to admin_categories_url, notice: 'Category was successfully destroyed.'
    end

    private

    def secure_params
      params.require(:category).permit(:name)
    end

    def set_category
      @category = Category.find(params[:id])
    end
  end
end

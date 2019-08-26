# frozen_string_literal: true

class CategoriesController < ApplicationController
  before_action :set_category, only: %i[show edit update destroy]

  def index
    @categories = Category.all
  end

  def new
    @category = Category.new
  end

  def show;  end

  def edit;  end

  def update
    if @category.update(secure_params)
      flash[:success] = 'Category successfully updated'
      redirect_to @category
    else
      flash.now[:danger] = @category.errors.full_messages.to_sentence
      render :edit
    end
  end

  def create
    @category = Category.new secure_params

    if @category.save
      redirect_to(@category, notice: 'Category was successfully created')
    else
      flash.now[:danger] = @category.errors.full_messages.to_sentence
      render :new
    end
  end

  def destroy
    @category.destroy

    redirect_to categories_url
  end

  private

  def secure_params
    params.require(:category).permit(:name)
  end

  def set_category
    @category = Category.find(params[:id])
  end
end

# frozen_string_literal: true

class CategoriesController < ApplicationController
  before_action :set_category, only: %i[show edit update destroy]
  before_action :require_admin, except: %i[index show]

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
    redirect_to categories_url, notice: 'Category was successfully destroyed.'
  end

  private

  def secure_params
    params.require(:category).permit(:name)
  end

  def set_category
    @category = Category.find(params[:id])
  end

  def require_admin
    return redirect_to root_path, alert: 'Only admin users can perform that action' unless admin_user_signed_in?
  end
end

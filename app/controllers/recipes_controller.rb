class RecipesController < ApplicationController
    def create
        begin
        user = User.find(session[:user_id])
        new_recipe = user.recipes.create(recipe_params)
        if new_recipe.valid?
        render json: new_recipe,status:201
        else
        render json: {errors:["Not valid"]},status:422
        end
        rescue ActiveRecord::RecordNotFound => e
        render json: {errors:[e]},status:401
        end

    end

    def index
        begin
            user = User.find(session[:user_id])
            recipes = user.recipes
            render json: recipes, include: :user
        rescue ActiveRecord::RecordNotFound => e
            render json: {errors:[e]},status:401
        end
    end

    private
    def recipe_params
        params.permit(:title,:instructions,:user_id,:minutes_to_complete)
    end
end
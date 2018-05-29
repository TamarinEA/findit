#
#  Example usage:
#
#  #/app/finders/posts_finders.rb
#  class PostFinder
#    include Findit::Collections
#
#    cache_key do
#      [@user.id, @query]
#    end
#
#    def initialize(user, options = {})
#      @user = user
#      @query = options[:query]
#    end
#
#    private
#
#    def find
#      scope = scope.where(user_id: @user.id)
#      scope = scope.where('description like :query', query: @query) if @query.present?
#      scope
#    end
#  end
#
#  #/app/controllers/posts_controller.rb
#  class PostsController < ApplicationController
#    def index
#      @posts = PostFinder.new(user: current_user)
#    end
#  end
#
#  #/app/views/posts/index.html.erb
#  <% cache(@posts, tags: @posts.cache_tags, expires_in: @posts.expires_in) do %>
#    <%= render 'post' colection: @posts, as: :post%>
#
module Findit
  module Collections
    include Enumerable
    extend ActiveSupport::Concern

    included do
      include ::Findit::Single
      delegate :each, :[], :size, :empty?, :to_ary, :to_a, :shift, to: :call
    end
  end
end

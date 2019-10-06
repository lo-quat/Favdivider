class Parameter

  def initialize(params = {})
    @category_id = params[:category] ? params[:category][:id] : nil
    @tweet_text = params[:tweet_text].presence
    @like_num = params[:like_num] ? params[:like_num].to_i : nil
    @clip = params[:clip].presence
    @sort = params[:sort].presence
    @quote = params[:quote].presence
    @image = params[:image].presence
    @video = params[:video].presence
  end

  def define_params
    return {
        tweet_text: @tweet_text,
        like_num: @like_num,
        clip: @clip,
        category_id: @category_id,
        sort: @sort,
        quote: @quote,
        image: @image,
        video: @video
    }.with_indifferent_access.freeze
  end
end
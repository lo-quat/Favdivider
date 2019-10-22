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

    # PostUser検索の時params[:q]を整理して複数単語検索に対応させる
    words = params[:q].delete(:search_words_cont) if params[:q].present?
    if words.present?
      params[:q][:groupings] = []
      words.split(/[ 　]/).each_with_index do |word, i| #全角空白と半角空白で切って、単語ごとに処理
        params[:q][:groupings][i] = {search_words_cont: word}
      end
    end
    @q = params[:q]
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
        video: @video,
    }.with_indifferent_access.freeze
  end

  def post_user_params
    @q
  end
end
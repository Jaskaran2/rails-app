class ArticlesController<ApplicationController
    before_action :require_user_logged_in!
   
    def index
        @articles = Article.all       
    end

    def show
       @article||= Article.find(params[:id])
    end

    def new
        if Current.user.nil?
            redirect_to sign_in_path,notice: "You first need to sign in!!"
        else
        @article = Current.user.articles.new
        end
    end
    
      def create
        @article =Current.user.articles.new(article_params)
    
        if @article.save
          redirect_to root_path,notice: "Post created"
        else
          flash[:error]="Wrong inputs!! Something is missing"
          render :new 
        end
      end

      def edit
        @article = Current.user.articles.find(params[:id])
      end
    
      def update
        @article = Current.user.articles.find(params[:id])
        if @article.update(article_params)
            redirect_to root_path
        else
            puts "Wrong inputs!! Something is missing"
            redirect_to new_article_path 
        end
      end

    def destroy
        @article = Current.user.articles.find(params[:id])
        @article.destroy

        redirect_to root_path, status: 303
      end

      def myall
        @my_articles=Current.user.articles.all
      end
     
      def archived
        @archived=Current.user.articles.all
      end

    private

    def article_params
      params.require(:article).permit(:title, :body,:status)
    end


end
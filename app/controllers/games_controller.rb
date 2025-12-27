class GamesController < ApplicationController
  TOTAL_TURNS = 5
  START_MONEY = 50000

  def start
    # 初期化
    session[:money] = START_MONEY
    session[:turn]  = 1
  end

  def play
    @money = session[:money]
    @turn  = session[:turn]

    # ターン数が上限を超えたら結果画面へ
    redirect_to result_path if @turn > TOTAL_TURNS
  end

  def choose
    amount = params[:amount].to_i

    session[:money] -= amount
    session[:turn]  += 1

    redirect_to play_path
  end

  def result
    @money = session[:money]
  end
end

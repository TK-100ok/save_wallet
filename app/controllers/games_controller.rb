class GamesController < ApplicationController
  before_action :set_game_state, only: %i[play choose result]

  TOTAL_TURNS = 5
  START_MONEY = 50000

  def start
     reset_game
  end

  def play
    @child = current_child
    redirect_to result_path if last_turn?
  end

  def choose
    amount = params[:amount].to_i

    if amount < current_child[:optimal]
      redirect_to game_over_path and return
    end

    update_money(amount)
    next_turn

    redirect_to play_path
  end

  def game_over; end

  def result
    @rank, @message = evaluation(@money)
  end

  private

  def reset_game
    session[:money] = START_MONEY
    session[:turn]  = 0
  end

  def set_game_state
    @money = session[:money]
    @turn  = session[:turn]
  end

  def update_money(amount)
    session[:money] -= amount
  end

  def next_turn
    session[:turn] += 1
  end

  def last_turn?
    @turn >= TOTAL_TURNS
  end

  def current_child
    ChildrenData::LIST[@turn]
  end

  def evaluation(money)
    case money
    when 33000
      ["ケチ神様！！", "ケチの極み！ケチ神様の称号を授けましょう！"]
    when 0
      ["仏様！！", "自分より子供に投資するあなたは美しい...誇っていい"]
    when 28000..32000
      ["いいケチっぷり！", "しっかり分析できています！ケチ神までもう少し！"]
    when 20000..27000
      ["もっとケチれる！", "いいケチっぷりですが、まだまだ改善の余地あり！"]
    else
      ["渡しすぎた...", "そんなに渡して大丈夫？お金は大切に"]
    end
  end
end

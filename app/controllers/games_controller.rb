class GamesController < ApplicationController
  TOTAL_TURNS = 5
  START_MONEY = 50000

  CHILDREN = [
   {
     name: "はなこ",
     image: "kids/kid2.png",
     line: "お年玉って、いい文化だよね？",
     optimal: 5000
   },
   {
     name: "ゆうと",
     image: "kids/kid3.png",
     line: "今年はゲーミングPCが欲しくて…！",
     optimal: 10000
   },
   {
     name: "みゆ",
     image: "kids/kid4.png",
     line: "私、一番いい子にしてたよね？",
     optimal: 1000
   },
   {
     name: "けんと",
     image: "kids/kid5.png",
     line: "お兄ちゃん信じてるよ？",
     optimal: 5000
   },
   {
     name: "たろう",
     image: "kids/kid1.png",
     line: "お正月だよ！ちょうだい！",
     optimal: 3000
   }
  ]

  def start
    # 初期化
    session[:money] = START_MONEY
    session[:turn]  = 0
  end

  def play
    @money = session[:money]
    @turn  = session[:turn]
    @child = CHILDREN[session[:turn]]

    # ターン数が上限を超えたら結果画面へ
    redirect_to result_path if @turn + 1 > TOTAL_TURNS
  end

  def choose
  amount = params[:amount].to_i

  # 今の子供データを取得
  child = CHILDREN[session[:turn]]

  # 最適解を渡せなかったらゲームオーバー
  if amount < child[:optimal]
    redirect_to game_over_path and return
  end

  # 渡せたら次へ
  session[:money] -= amount
  session[:turn]  += 1

  redirect_to play_path
  end

  def game_over
  end

  def result
    @money = session[:money]

    @rank =
    if @money == 26000
      "S"
    elsif (20000..25000).include?(@money)
      "A"
    elsif (10000..19000).include?(@money)
      "B"
    else
      "C"
    end
  end
end

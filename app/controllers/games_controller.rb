class GamesController < ApplicationController
  TOTAL_TURNS = 5
  START_MONEY = 50000

  CHILDREN = [
    {
     name: "太郎",
     age: 6,
     image: "kids/kid1.png",
     line: "あけまして、おめでとーございます😊",
     impress: "おおきくなったなぁ。6歳か...",
     optimal: 1000
   },
   {
     name: "親戚の集まりにいる知らない子",
     age: 6,
     image: "kids/kid2.png",
     line: "お年玉って、いい文化だね？",
     impress: "誰の子だ？わからない...わからないが...",
     optimal: 1000
   },
   {
     name: "通りすがりの一般中学生",
     age: 14,
     image: "kids/kid3.png",
     line: "ゲーミングPCが欲しいの…！",
     impress: "何言ってんだこいつ...",
     optimal: 0
   },
   {
     name: "歳の離れた従兄弟",
     age: 16,
     image: "kids/kid4.png",
     line: "なんだよ...お年玉くれんの？",
     impress: "昔はあんなに可愛かったのに、今となっては...とはいえもう高校生か...",
     optimal: 5000
   },
   {
     name: "最近産まれた兄の子供",
     age: 0,
     image: "kids/kid5.png",
     line: "☺️",
     impress: "お金という概念がまだ存在しない純粋な赤ちゃんだ。０歳にお年玉なんていらな...あれ？出産祝い渡してないな...",
     optimal: 10000
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
    if @money == 33000
      "ケチ神様！！"
    elsif @money == 0
      "仏様！！"
    elsif (28000..32000).include?(@money)
      "いいケチっぷり！"
    elsif (20000..27000).include?(@money)
      "もっとケチれる！"
    else
      "渡しすぎた..."
    end

    @message =
    if @money == 33000
      "ケチの極み！ケチ神様の称号を授けましょう！"
    elsif @money == 0
      "自分より子供に投資するあなたは美しい...誇っていい"
    elsif (28000..32000).include?(@money)
      "しっかり分析できています！ケチ神までもう少し！"
    elsif (20000..27000).include?(@money)
      "いいケチっぷりですが、まだまだ改善の余地あり！"
    else
      "そんなに渡して大丈夫？お金は大切に"
    end
  end
end

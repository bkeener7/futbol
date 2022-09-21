require 'csv'
require 'rspec'
require './lib/season_stats'

RSpec.describe SeasonStats do
  before(:each) do
   @seasonstats = SeasonStats.from_csv_paths({game_csv:'./data/games.csv', gameteam_csv:'./data/game_teams.csv', team_csv:'./data/teams.csv'})
  end

  it "maps coach records for a particular season" do

    expected = [["Joel Quenneville", 0.46534653465346537],
    ["Ken Hitchcock", 0.42045454545454547],
    ["Mike Yeo", 0.3894736842105263],
    ["Patrick Roy", 0.4044943820224719],
    ["Darryl Sutter", 0.49074074074074076],
    ["Bruce Boudreau", 0.5157894736842106],
    ["Lindy Ruff", 0.38636363636363635],
    ["John Tortorella", 0.4024390243902439],
    ["Craig Berube", 0.3953488372093023],
    ["Mike Babcock", 0.3563218390804598],
    ["Todd Richards", 0.4318181818181818],
    ["Adam Oates", 0.2682926829268293],
    ["Bob Hartley", 0.2926829268292683],
    ["Barry Trotz", 0.3780487804878049],
    ["Claude Julien", 0.574468085106383],
    ["Michel Therrien", 0.4444444444444444],
    ["Dan Bylsma", 0.4842105263157895],
    ["Jack Capuano", 0.2682926829268293],
    ["Claude Noel", 0.2765957446808511],
    ["Jon Cooper", 0.3372093023255814],
    ["Kevin Dineen", 0.1875],
    ["Todd McLellan", 0.4606741573033708],
    ["Ted Nolan", 0.20967741935483872],
    ["Randy Carlyle", 0.2682926829268293],
    ["Dave Tippett", 0.34146341463414637],
    ["Peter DeBoer", 0.3780487804878049],
    ["Peter Horachek", 0.22727272727272727],
    ["Paul Maurice", 0.34285714285714286],
    ["Paul MacLean", 0.2926829268292683],
    ["Dallas Eakins", 0.23170731707317074],
    ["Alain Vigneault", 0.45794392523364486],
    ["Kirk Muller", 0.3780487804878049],
    ["Ron Rolston", 0.1],
    ["Peter Laviolette", 0.0]]

    expect(@seasonstats.coach_stats("20132014")).to eq(expected)
  end

  it "calculates team accuracy for a season" do
    #add dummy files(~10 lines) in spec directory under fixture sub-directory

    expected = {"16"=>0.3042362002567394,
    "19"=>0.31129032258064515,
    "30"=>0.30363036303630364,
    "21"=>0.31484502446982054,
    "26"=>0.28327228327228327,
    "24"=>0.3347763347763348,
    "25"=>0.30015082956259426,
    "23"=>0.26655629139072845,
    "4"=>0.292259083728278,
    "17"=>0.28780487804878047,
    "29"=>0.3003194888178914,
    "15"=>0.2819614711033275,
    "20"=>0.3166023166023166,
    "18"=>0.2938053097345133,
    "6"=>0.3064066852367688,
    "8"=>0.29685157421289354,
    "5"=>0.30377906976744184,
    "2"=>0.2947019867549669,
    "52"=>0.29411764705882354,
    "14"=>0.3076923076923077,
    "13"=>0.2641509433962264,
    "28"=>0.2739541160593792,
    "7"=>0.2682445759368836,
    "10"=>0.31307550644567217,
    "27"=>0.28907563025210087,
    "1"=>0.3060428849902534,
    "9"=>0.2638888888888889,
    "22"=>0.2980769230769231,
    "3"=>0.27007299270072993,
    "12"=>0.2733224222585925}

    expect(@seasonstats.team_accuracy("20132014")).to eq(expected)
  end

  it "#winningest_coach" do
    expect(@seasonstats.winningest_coach("20132014")).to eq "Claude Julien"
    expect(@seasonstats.winningest_coach("20142015")).to eq "Alain Vigneault"
  end

  it "#worst_coach" do
    expect(@seasonstats.worst_coach("20132014")).to eq "Peter Laviolette"
    expect(@seasonstats.worst_coach("20142015")).to eq("Craig MacTavish").or(eq("Ted Nolan"))
  end

  it "#most_accurate_team" do
    expect(@seasonstats.most_accurate_team("20132014")).to eq "Real Salt Lake"
    expect(@seasonstats.most_accurate_team("20142015")).to eq "Toronto FC"
  end

  it "#least_accurate_team" do
    expect(@seasonstats.least_accurate_team("20132014")).to eq "New York City FC"
    expect(@seasonstats.least_accurate_team("20142015")).to eq "Columbus Crew SC"
  end

  it "#most_tackles" do
    expect(@seasonstats.most_tackles("20132014")).to eq "FC Cincinnati"
    expect(@seasonstats.most_tackles("20142015")).to eq "Seattle Sounders FC"
  end

  it "#fewest_tackles" do
    expect(@seasonstats.fewest_tackles("20132014")).to eq "Atlanta United"
    expect(@seasonstats.fewest_tackles("20142015")).to eq "Orlando City SC"
  end
end

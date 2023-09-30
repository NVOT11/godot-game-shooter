extends Node
# グローバルな変数

var Score :=  0
var Finished := false
var Energy := 0
var Max_Energy := 100

var OnMobile := false


func Initialize():
	Score = 0
	Finished = false
	Energy = Max_Energy


func Get_Score():
	return Score


func Add_Score(score: int):
	Score = Clamp_Score(Score + score)


func Set_Score(score: int):
	Score = Clamp_Score(score)


func Clamp_Score(num:int):
	if num <= 0:
		num = 0
	if num >= GameData.SCORE_MAX:
		num = GameData.SCORE_MAX
	return num


func Use_Energy(use : int):
	if Energy - use < 0:
		return false
	else:
		var dif = Energy - use
		Energy = Clap_Energy(dif)
		return true


func Recover_Energy(recover : int):
	var dif = Energy + recover
	Energy = Clap_Energy(dif)


func Clap_Energy(num : int):
	if num <= 0:
		num = 0
	if num >= Max_Energy:
		num = Max_Energy
	return num

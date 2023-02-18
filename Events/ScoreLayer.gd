extends CanvasLayer

func _ready():
	PlayerGlobal.connect("score_updated", self, "update_score")
	PlayerGlobal.connect("health_updated", self, "update_health")
	PlayerGlobal.connect("bread_updated", self, "update_bread")
	
	$ColorRect/LblScore.text = "%016d" % PlayerGlobal.score
	for i in $ColorRect/LblScore/Hearts.get_child_count():
		if PlayerGlobal.health < i + 1:
			$ColorRect/LblScore/Hearts.get_children()[i].texture = Global.empty_heart
		else:
			$ColorRect/LblScore/Hearts.get_children()[i].texture = Global.full_heart
	$ColorRect/LblScore/Breads/breadLbl.text = "x%02d" % PlayerGlobal.bread
	
func update_score(score_to_add):
	if score_to_add >= 9999999999999999:
		score_to_add = 9999999999999999
	$ColorRect/LblScore.text = "%016d" % score_to_add

func update_health(new_health):
	for i in $ColorRect/LblScore/Hearts.get_child_count():
		if new_health < i + 1:
			$ColorRect/LblScore/Hearts.get_children()[i].texture = Global.empty_heart
		else:
			$ColorRect/LblScore/Hearts.get_children()[i].texture = Global.full_heart
			
func update_bread(bread):
	if bread % 100 == 0:
		bread = 0
		PlayerGlobal.num_of_lives += 1
	$ColorRect/LblScore/Breads/breadLbl.text = "x%02d" % bread
	

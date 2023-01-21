
INSERT INTO `addon_account` (name, label, shared) VALUES
	('society_uwucafe', 'Uwucafe', 1)
;

INSERT INTO `addon_inventory` (name, label, shared) VALUES
	('society_uwucafe', 'Uwucafe', 1)
;

INSERT INTO `datastore` (name, label, shared) VALUES
	('society_uwucafe', 'Uwucafe', 1)
;

INSERT INTO `jobs` (name, label) VALUES
	('uwucafe', 'Uwucafe')
;

INSERT INTO `job_grades` (job_name, grade, name, label, salary, skin_male, skin_female) VALUES
	('uwucafe',0,'employer','Employer',12,'{}','{}'),
	('uwucafe',1,'manager','Manager',36,'{}','{}'),
	('uwucafe',2,'patron',"Boss",48,'{}','{}')
;

INSERT INTO `items` (name, label) VALUES 
	('the', 'The'),
	('bubbletea', "Bubble Tea"),
	('patemochi', "Pate a mochi"),
	('patepizza', "Pate a pizza"),
	('cafe', "Cafe"),
	('mochi', "Mochi"),
	('pizzacat', "Pizza Chat"),
	('latte', "Latte"),
	('coca', "Coca-cola"),
	('icetea', "Ice-Tea"),
	('mogu', "Mogu Mogu")
;
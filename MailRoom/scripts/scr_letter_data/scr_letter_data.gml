enum FIELD_TYPES {
	DATE,
	NUMBER,
	COST,
	NOUN,
	VERB
}

enum NAMES {
	EXECUTIVE,
	MARKETING,
	JETSTREAM,
	FINANCIAL,
	LEGAL,
	TIMES,
	REVIEWERS
}

// called when a week/level is started - generate the data for all the letters
function get_letter_data(_week, _path){
	var _return = pointer_null;
	switch (_week) {
		case 1:
			_return = [
				{
					title: "LaunchWindow1",
					addresses : [NAMES.EXECUTIVE, NAMES.JETSTREAM],
					letter_text: "Launch Window Confirmed\n\nWe got the final green light. The ~0~ units begin regional rollout ~1~.\n\nInventory Shipment is on its way to your stores. You should receive ~2~ units within the next few days.",
					fields: [[FIELD_TYPES.NOUN, "Gizmo 3000"], [FIELD_TYPES.DATE, "November 30"], [FIELD_TYPES.NUMBER, "2400"]]
				},
				{
					title: "ExpenseApproval1",
					addresses : [NAMES.MARKETING, NAMES.FINANCIAL],
					letter_text: "Expense Approval Form\n\nApproval requested for: ~0~ ~1~ units for product showcase.\n\nNeeded by date: ~2~\n\nCost Per Unit: ~3~\n\n*Upon approval, a letter will be sent to # Executive Dept # telling them to fulfill this order.*",
					fields: [[FIELD_TYPES.NUMBER, "3"], [FIELD_TYPES.NOUN, "Projectors"], [FIELD_TYPES.DATE, "November 20"], [FIELD_TYPES.COST, "$200"]]
				},
				{
					title: "PossibleLegal1",
					addresses : [NAMES.LEGAL, NAMES.MARKETING],
					letter_text: "Possible Legal Concern\n\nLegal approval is still pending on the Gizmo 3000's high-frequency emitter system.\n\nFor the next ~0~ days, don't mention this functionality of the product in any promotional materials, or we may be looking at a ~1~ fine.",
					fields: [[FIELD_TYPES.NUMBER, "10"], [FIELD_TYPES.COST, "$1,000,000"]]
				}

			]
			break;
			
		case 2:
			_return = [
				{
					title: "OfficeMorale1",
					addresses : [NAMES.EXECUTIVE, NAMES.MARKETING],
					letter_text: "Office Morale Conditions\n\nWith the product launch looming, some of our ~0~ have been experiencing minor crunch.\n\nWhatever you do, don't let the rumors about them ~1~ reach the public. It would be a PR disaster.",
					fields: [[FIELD_TYPES.NOUN, "Employees"],[FIELD_TYPES.VERB, "Passing out"]]
				},
				{
					title: "WriteUs1",
					addresses : [NAMES.MARKETING, NAMES.TIMES],
					letter_text: "Write us an Article!\n\nPlease write an article about how early testers of the ~0~ are ~1~ to be published in your ~2~ edition.\n\nThanks!",
					fields: [[FIELD_TYPES.NOUN, "Gizmo 3000"], [FIELD_TYPES.VERB, "Feeling more productive than ever"],[FIELD_TYPES.DATE, "November 20"]]
				}
			]
			// PATH D (Default following A)
			array_push(_return, {
				title: "SoundsGood1",
				addresses : [NAMES.JETSTREAM, NAMES.EXECUTIVE],
				letter_text: "Sounds Good!\n\nWe've received the shipment of ~0~ units, and will begin distributing them in ~1~ days!",
				fields: [[FIELD_TYPES.NOUN, "Gizmo 3000"],[FIELD_TYPES.NUMBER, "14"]]
			})
			if (found_path(_path, "f")) {
					_return[array_length(_return) - 1] = {
						title: "WrongProduct1",
						addresses : [NAMES.JETSTREAM, NAMES.EXECUTIVE],
						letter_text: "Wrong Product Received?\n\nWe heard from you that a shipment of projectors was on its way over to us, but it seems we received ~0~ ~1~ units instead.\n\nWe await the arrival of the projectors. Additionally, unless we head from you soon, we'll discard all of the units we received.",
						fields: [[FIELD_TYPES.NUMBER, "2400"],[FIELD_TYPES.NOUN, "Gizmo 3000"]]
					}
			}
			if (found_path(_path, "b")) {
					_return[array_length(_return) - 1] = {
						title: "DemoShipment1",
						addresses : [NAMES.JETSTREAM, NAMES.EXECUTIVE],
						letter_text: "Demo Shipment Received!\n\nThank you for the demo products for us to display in our stores!\n\nWhen should we expect the final shipment of products for retail?",
						fields: []
					}
			}
			if (found_path(_path, "h")) {
					_return[array_length(_return) - 1] = {
						title: "SoundsGood2",
						addresses : [NAMES.JETSTREAM, NAMES.EXECUTIVE],
						letter_text: "Sounds Good!\n\nWe've received the shipment, and will begin distributing them shortly!",
						fields: []
					}
			}


			// PATH K (Default following ExpenseApproval1)
			array_push(_return, {
				title: "FulfillOrder2",
				addresses : [NAMES.FINANCIAL, NAMES.EXECUTIVE],
				letter_text: "Fulfill Order\n\nWe've approved an order for the purchase of ~0~ ~1~.\n\nPlease order these and grant them to the @ Marketing Dept @ by ~2~.",
				fields: [[FIELD_TYPES.NUMBER, "3"],[FIELD_TYPES.NOUN, "Projectors"],[FIELD_TYPES.DATE, "November 20"]]
			})
			if (found_path(_path, "i")) {
					_return[array_length(_return) - 1] = {
						title: "ApprovalForm1",
						addresses : [NAMES.FINANCIAL, NAMES.MARKETING],
						letter_text: "Approval Form Rejected\n\nUnfortunately, thousands of ~0~ is simply not within our budget. Perhaps fewer would suffice?",
						fields: [[FIELD_TYPES.NOUN, "Projectors"]]
					}
			}
			if (found_path(_path, "j")) {
					_return[array_length(_return) - 1] = {
						title: "FulfillOrder1",
						addresses : [NAMES.FINANCIAL, NAMES.EXECUTIVE],
						letter_text: "Fulfill Order\n\nWe've approved an order for the purchase of ~0~ ~1~.\n\nPlease order these and grant them to the @ Marketing Dept @ by ~2~",
						fields: [[FIELD_TYPES.NUMBER, "10"],[FIELD_TYPES.NOUN, "Projectors"],[FIELD_TYPES.DATE, "November 20"]]
					}
			}
			if (found_path(_path, "l")) {
					_return[array_length(_return) - 1] = {
						title: "FulfillOrder3",
						addresses : [NAMES.FINANCIAL, NAMES.EXECUTIVE],
						letter_text: "Fulfill Order\n\nPlease grant ~0~ ~1~ units to @ Marketing Dept @ by ~2~.",
						fields: [[FIELD_TYPES.NUMBER, "3"],[FIELD_TYPES.NOUN, "Gizmo 3000"],[FIELD_TYPES.DATE, "November 20"]]
					}
			}
			if (found_path(_path, "m")) {
					_return[array_length(_return) - 1] = {
						title: "FulfillOrder4",
						addresses : [NAMES.FINANCIAL, NAMES.EXECUTIVE],
						letter_text: "Fulfill Order\n\nWe've approved an order for the purchase of ~0~ ~1~.\n\nPlease order these and grant them to the @ Marketing Dept @ by ~2~",
						fields: [[FIELD_TYPES.NUMBER, "3"],[FIELD_TYPES.NOUN, "Projectors"],[FIELD_TYPES.DATE, "November 30"]]
					}
			}

			if (found_path(_path, "n")) {
					_return[array_length(_return) - 1] = {
						title: "ApprovalForm2",
						addresses : [NAMES.FINANCIAL, NAMES.MARKETING],
						letter_text: "Approval Form Rejected\n\nUnfortunately, ~0~ that cost ~1~ are simply not within our budget. Perhaps cheaper ones would suffice?",
						fields: [[FIELD_TYPES.NOUN, "Projectors"],[FIELD_TYPES.COST, "$1,000,000"]]
					}
			}


			// PATH Q (Default following PossibleLegal1)
			array_push(_return, {
				title: "TemporaryRefrain2",
				addresses : [NAMES.MARKETING, NAMES.LEGAL],
				letter_text: "Temporary Refrain\n\nThanks for the heads up. We'll refrain from ~0~ until then.\n\nUnfortunately, this means we won't be able to mention this feature during the product showcase, which may hinder sales slightly, but at least it'll be approved by product release.",
				fields: [[FIELD_TYPES.VERB, "Mentioning this"]]
			})
			if (found_path(_path, "o")) {
					_return[array_length(_return) - 1] = {
						title: "DevastatingNews1",
						addresses : [NAMES.MARKETING, NAMES.EXECUTIVE],
						letter_text: "Devastating News\n\nWe've just received word from } Legal } that the high-frequency emitter system won't be approved for potentially the entire lifespan of the product.\n\nThis is devastating news, and means that the firmware must be updated immediately on all units to remove this feature.",
						fields: []
					}
			}
			if (found_path(_path, "p")) {
					_return[array_length(_return) - 1] = {
						title: "TemporaryRefrain1",
						addresses : [NAMES.MARKETING, NAMES.LEGAL],
						letter_text: "Temporary Refrain\n\nThanks for the heads up. We'll refrain from ~0~ until then.\n\nAt least we'll be able to talk about it during the product showcase on November 21!",
						fields: [[FIELD_TYPES.VERB, "Mentioning this"]]
					}
			}
			if (found_path(_path, "r")) {
					_return[array_length(_return) - 1] = {
						title: "ExpenseApproval2",
						addresses : [NAMES.MARKETING, NAMES.FINANCIAL],
						letter_text: "Expense Approval Form\n\nApproval requested for: Coverage of the legal fine for mentioning an unapproved feature of the product in promotional materials.\n\nTotal Cost: ~0~\n\n*If approval is granted, we will promote this feature in the upcoming product showcase, despite the small fine.*",
						fields: [[FIELD_TYPES.COST, "$200"]]
					}
			}



			break;

		case 3:
			_return = [
				{
					title: "TestProducts1",
					addresses : [NAMES.MARKETING, NAMES.REVIEWERS],
					letter_text: "Test Products!\n\nHere are some test units of the ~0~ for you to write reviews of!\n\n(PS: If you write an overwhelmingly positive review, we'll pay you ~1~.)",
					fields: [[FIELD_TYPES.NOUN, "Gizmo 3000"],[FIELD_TYPES.COST, "$5,000"]]
				},
				{
					title: "FinalProduct1",
					addresses : [NAMES.EXECUTIVE, NAMES.JETSTREAM],
					letter_text: "Final Product Pricing\n\nWe've just held a meeting about the final product pricing, and come to the conclusion that the ~0~ should retail for ~1~ per unit.",
					fields: [[FIELD_TYPES.NOUN, "Gizmo 3000"], [FIELD_TYPES.COST, "$199"]]
				},
				{
					title: "LegalWarning1",
					addresses : [NAMES.LEGAL, NAMES.EXECUTIVE],
					letter_text: "Legal Warning\n\nFor legal reasons, we need to include text on the box that says users are ~0~ as a result of using our product.",
					fields: [[FIELD_TYPES.VERB, "Not guaranteed divine bliss"]]
				}

			]
			if (found_path(_path, "e")) {
					array_push(_return, {
						title: "WrongProduct2",
						addresses : [NAMES.EXECUTIVE, NAMES.JETSTREAM],
						letter_text: "Wrong Product Received!\n\nSomething must've happened in transit, but you received the wrong product! We have another shipment of Gizmo 3000 units on the way to your stores!",
						fields: []
					})
			}
			if (found_path(_path, "g")) {
					array_push(_return, {
						title: "CorrectProduct1",
						addresses : [NAMES.EXECUTIVE, NAMES.JETSTREAM],
						letter_text: "Correct Product Received!\n\nSome miscommunication must've happened along the way, but whatever you do, don't ~0~ those Gizmo 3000 units! Those are what we actually want you to sell, not the projectors.",
						fields: [[FIELD_TYPES.VERB, "Throw away"]]
					})
			}
			if (found_path(_path, "s")) {
					array_push(_return, {
						title: "ExpenseApproval2",
						addresses : [NAMES.FINANCIAL, NAMES.MARKETING],
						letter_text: "Expense Approval Form\n\nRequest approved. You may tank the small fine for mentioning this product in the showcase.",
						fields: []
					})
			}
			if (found_path(_path, "t")) {
					array_push(_return, {
						title: "ExpenseApproval3",
						addresses : [NAMES.FINANCIAL, NAMES.MARKETING],
						letter_text: "Expense Approval Form\n\nRequest denied. This cost is too high for it to be within our budget. Please refrain from mentioning the high-frequency emitter system during the conference.",
						fields: []
					})
			}
			if (found_path(_path, "u")) {
					array_push(_return, {
						title: "Hilarious1",
						addresses : [NAMES.MARKETING, NAMES.EXECUTIVE],
						letter_text: "Hilarious!\n\nFunny joke, but it's good to hear that the ~0~ are ~1~!",
						fields: [[FIELD_TYPES.NOUN, "Eployees"],[FIELD_TYPES.VERB, "Feeling more productive than ever"]]
					})
			}
			break;

	}
	return _return;
}

// called at the end of a level/week - make logical checks that determine
// what adjustments will be made to next week's batch of letters
function get_path(_week, _letters) {
	var _return = "";
	switch (_week) {
		case 1:
			//if (get_letter_title(_letters, "Report 1", 0, "1000")) _return = _return + "a";
			//if (get_letter_title(_letters, "Newseletter 1", 0, "ice_cream")) _return = _return + "b";
			
			if (get_letter_title(_letters, "LaunchWindow1", 2, "10")) _return = _return + "b";
			else if (get_letter_title(_letters, "LaunchWindow1", 2, "3")) _return = _return + "b";
			else if (get_letter_title(_letters, "LaunchWindow1", 0, "Projectors")) _return = _return + "f";
			else if (get_letter_title(_letters, "LaunchWindow1", 1, "November 20")) _return = _return + "h";
			else _return = _return + "d";

			if (get_letter_title(_letters, "ExpenseApproval1", 0, "2400")) _return = _return + "i";
			else if (get_letter_title(_letters, "ExpenseApproval1", 0, "10")) _return = _return + "j";
			else if (get_letter_title(_letters, "ExpenseApproval1", 1, "Gizmo 3000")) _return = _return + "l";
			else if (get_letter_title(_letters, "ExpenseApproval1", 2, "November 30")) _return = _return + "m";
			else if (get_letter_title(_letters, "ExpenseApproval1", 3, "$1,000,000")) _return = _return + "n";
			else _return = _return + "k";

			if (get_letter_title(_letters, "PossibleLegal1", 0, "2400")) _return = _return + "o";
			else if (get_letter_title(_letters, "PossibleLegal1", 0, "3")) _return = _return + "p";
			else if (get_letter_title(_letters, "PossibleLegal1", 1, "$200")) _return = _return + "r";
			else _return = _return + "q";

			//3
			if (get_letter_title(_letters, "SoundsGood1", 0, "Employees")) _return = _return + "e";
			if (get_letter_title(_letters, "SoundsGood1", 0, "Projectors")) _return = _return + "e";
			if (get_letter_title(_letters, "WrongProduct1", 1, "Eployees")) _return = _return + "";
			else if (get_letter_title(_letters, "WrongProduct1", 1, "Projectors")) _return = _return + "";
			else if (get_letter_title(_letters, "WrongProduct1", 0, "3")) _return = _return + "";
			else _return = _return + "g";
			if (get_letter_title(_letters, "ExpenseApproval2", 0, "$1,000,000")) _return = _return + "s";
			else _return = _return + "t";
			if (get_letter_title(_letters, "OfficeMorale1", 1, "Feeling more productive than ever")) _return = _return + "u";
			
			break;
			
		case 2:
			//Cutscenes after day 2
			if (get_letter_title(_letters, "DemoShipment1", -1, "True")) _return = _return + "A";
			if (get_letter_title(_letters, "DemoShipment2", 1, "3")) _return = _return + "B";
			if (get_letter_title(_letters, "DemoShipment2", 1, "10")) _return = _return + "C";
			if (get_letter_title(_letters, "WrongProduct1", 1, "Employees")) _return = _return + "D";
			if (get_letter_title(_letters, "WrongProduct1", 1, "Projectors")) _return = _return + "E";
			if (get_letter_title(_letters, "WrongProduct1", 0, "3")) _return = _return + "F";
			if (get_letter_title(_letters, "SoundsGood2", -1, "True")) _return = _return + "G";
			if (get_letter_title(_letters, "ApprovalForm1", 0, "Employees")) _return = _return + "H";
			if (get_letter_title(_letters, "FulfillOrder2", 0, "2400")) _return = _return + "I";
			if (get_letter_title(_letters, "FulfillOrder2", 0, "14")) _return = _return + "K";
			if (get_letter_title(_letters, "FulfillOrder2", 1, "Employees")) _return = _return + "O";
			if (get_letter_title(_letters, "FulfillOrder2", 1, "Gizmo 3000")) _return = _return + "L";
			if (get_letter_title(_letters, "FulfillOrder1", 0, "2400")) _return = _return + "I";
			if (get_letter_title(_letters, "FulfillOrder1", 0, "14")) _return = _return + "K";
			if (get_letter_title(_letters, "FulfillOrder1", 1, "Employees")) _return = _return + "O";
			if (get_letter_title(_letters, "FulfillOrder1", 1, "Gizmo 3000")) _return = _return + "L";
			if (get_letter_title(_letters, "FulfillOrder3", 0, "14")) _return = _return + "K";
			else if (get_letter_title(_letters, "FulfillOrder3", 0, "2400")) _return = _return + "J";
			else _return = _return + "L";
			if (get_letter_title(_letters, "FulfillOrder4", 0, "14")) _return = _return + "N";
			else if (get_letter_title(_letters, "FulfillOrder3", 1, "Employees")) _return = _return + "O";
			else _return = _return + "M";
			if (get_letter_title(_letters, "ApprovalForm2", 0, "Employees")) _return = _return + "P";
			if (get_letter_title(_letters, "ApprovalForm2", 1, "$200")) _return = _return + "Q";
			if (get_letter_title(_letters, "DevastatingNews1", -1, "True")) _return = _return + "R";
			if (get_letter_title(_letters, "TemporaryRefrain1", 0, "Passing out")) _return = _return + "S";
	if (get_letter_title(_letters, "TemporaryRefrain1", 0, "Feeling more productive than ever")) _return = _return + "T";
			if (get_letter_title(_letters, "TemporaryRefrain2", 0, "Passing out")) _return = _return + "S";
	else if (get_letter_title(_letters, "TemporaryRefrain2", 0, "Feeling more productive than ever")) _return = _return + "T";
	else _return = _return + "U";
			if (get_letter_title(_letters, "ExpenseApproval2", 0, "$200")) _return = _return + "T";
			if (get_letter_title(_letters, "WriteUs1", 1, "Passing out")) _return = _return + "V";
			if (get_letter_title(_letters, "WriteUs1", 1, "Mentioning this")) _return = _return + "W";
			if (get_letter_title(_letters, "WriteUs1", 0, "Projectors")) _return = _return + "X";
			if (get_letter_title(_letters, "WriteUs1", 0, "Employees")) _return = _return + "Y";
			if (get_letter_title(_letters, "WriteUs1", 2, "November 30")) _return = _return + "Z";










			
		case 3:
			//Cutscenes after day 3
			if (get_letter_title(_letters, "WrongProduct1", -1, "True")) _return = _return + "1";
			if (get_letter_title(_letters, "ExpenseApproval2", -1, "True")) _return = _return + "2";
			if (get_letter_title(_letters, "TestProducts1", 1, "$199")) _return = _return + "4";
			else _return = _return + "3";
			if (get_letter_title(_letters, "FinalProduct1", 0, "Gizmo 3000")) _return = _return + "5";
			if (get_letter_title(_letters, "FinalProduct1", 1, "$5,000")) _return = _return + "6";
			if (get_letter_title(_letters, "LegalWarning1", 0, "Feeling more productive than ever")) _return = _return + "7";



			

			break;
	}
	return _return;
}



function get_cutscene(_week, _path) {
	var _return = "";
	switch (_week) {
		case 0:
			_return = "CLASSIFIED: Operation Gizmo Flop\nInfiltration Asset Assigned: Mailroom Clerk (Temp ID 80325)\nTarget: Pentacorp Industries\nObjective: Destabilize internal coordination to delay or sabotage the launch of the Gizmo 3000.\n\nPentacorp's going all-in on their new and improved Gizmo 3000 devices. Launch is three weeks out. Our job is to make sure it implodes before then.\n\nAs the mailroom clerk at Pentacorp, you'll receive incoming documents at the start of each week. Once you read them, swap out a word from one document with a word from another, and send them all back out.\n\nNo blood, no noise. Just paper cuts in the right places.\n\nBegin week one. Let’s set the foundation. Good luck agent.";
			break;
		case 1:
			_return = "Good work, agent.\nTwo more weeks of trickery to go!\n";
			//if (found_path(_path, "a")) {_return += ""}
			break;
			
		case 2:
			_return = "";
			if (found_path(_path, "A")) {_return += "Thousands of Gizmo 3000 units are lost in transit. Pentacorp suffers a big loss: -40%\n\n"}
			if (found_path(_path, "B")) {_return += "Jetstream Orders begins selling the Gizmo 3000 a week too early. Sales Plummet: -50%\n\n"}
			if (found_path(_path, "C")) {_return += "Jetstream Orders begins selling the Gizmo 3000 four days too early. Sales Drop: -20%\n\n"}
			if (found_path(_path, "D")) {_return += "Thousands of employees are shipped via the postal system, causing massive public outcry. Sales plummet: -50%\n\n"}
			if (found_path(_path, "E")) {_return += "Thousands of Gizmo 3000 units are lost in transit. Pentacorp suffers a big loss: -40%\n\n"}
			if (found_path(_path, "F")) {_return += "Thousands of Gizmo 3000 units are lost in transit. Pentacorp suffers a big loss: -40%\n\n"}
			if (found_path(_path, "G")) {_return += "Jetstream Orders begins distributing Gizmo 3000s ten days before the actual product launch. Sales plummet: -40%\n\n"}
			if (found_path(_path, "H")) {_return += "Pentacorp is reduced to below 2400 Employees, causing mass layoffs. Sales drop: -30%\n\n"}
			if (found_path(_path, "I")) {_return += "Marketing is given thousands of Projectors, costing Pentacorp tons of money: -30%\n\n"}
			if (found_path(_path, "J")) {_return += "Marketing is given thousands of Gizmo 3000s, and Jetstream is short stocked on launch! Sales plummet: -50%\n\n"}
			if (found_path(_path, "K")) {_return += "Marketing got more demo units than they asked for, leading to an even better product showcase!: +10%\n\n"}
			if (found_path(_path, "L")) {_return += "Marketing doesn't receive any projectors, so the product showcase goes terribly. Sales drop: -30%\n\n"}
			if (found_path(_path, "M")) {_return += "Marketing Dept doesn't receive their projectors in time for the product showcase: -20%\n\n"}
			if (found_path(_path, "N")) {_return += "14 Projectors are purchased, using slightly more funds than intended: -10%\n\n"}
			if (found_path(_path, "O")) {_return += "Three new employees are hired. Office productivity increases, and sales follow: +20%\n\n"}
			if (found_path(_path, "P")) {_return += "The CEO of Pentacorp is fired. Sales plummet: -40%\n\n"}
			if (found_path(_path, "Q")) {_return += "Marketing doesn't receive any projectors, so the product showcase goes terribly. Sales drop: -30%\n\n"}
			if (found_path(_path, "R")) {_return += "The high-frequency emitter feature is removed from all Gizmo 3000 units. Sales plummet: -30%\n\n"}
			if (found_path(_path, "S")) {_return += "Legal calls a fleet of ambulances for marketing out of fear that they are on the verge of passing out. This massive expense drops Pentacorp's value significantly: -20%\n\n"}
			if (found_path(_path, "T")) {_return += "Marketing Dept's lack of productivity leads to poor product promotion. Sales drop: -30%\n\n"}
			if (found_path(_path, "U")) {_return += "The high-frequency emitter feature can't be mentioned at the product showcase. Sales drop: -20%\n\n"}
			if (found_path(_path, "V")) {_return += "Many people are terrified of how the product supposedly causes people to pass out. Sales plummet: -50%\n\n"}
			if (found_path(_path, "W")) {_return += "The article is written, but it's utter nonsense: -10%\n\n"}
			if (found_path(_path, "X")) {_return += "An article is written about projectors, rather than the Gizmo 3000: -10%\n\n"}
			if (found_path(_path, "Y")) {_return += "An article is written, but it's utter nonsense: -10%\n\n"}
			if (found_path(_path, "Z")) {_return += "The article is published on the same day as product release, not before it: -10%\n\n"}
			break;

		case 3:
			_return = "";
			if (found_path(_path, "1")) {_return += "Pentacorp loses half their stock of  Gizmo 3000s. Sales plummet: -50%\n\n"}
			if (found_path(_path, "2")) {_return += "Marketing gets tricked into causing legal trouble during their product showcase, causing them a massive fine: -30%\n\n"}
			if (found_path(_path, "3")) {_return += "Early reviewers are bribed to write super positive reviews of the product. Sales increase: +20%\n\n"}
			if (found_path(_path, "4")) {_return += "Early reviewers are furious for being lowballed to lie. Many write scathing reviews of the product. Sales plummet: -30%\n\n"}
			if (found_path(_path, "5")) {_return += "Jetstream Orders sells their employees for $199 each. Nobody wants to buy the Gizmo 3000 anymore. Sales plummet: -40%\n\n"}
			if (found_path(_path, "6")) {_return += "Buyers don't want to cough up $5,000 for the Gizmo 3000. Sales plummet: -50%\n\n"}
			if (found_path(_path, "7")) {_return += "Pentacorp gets into legal trouble for false advertising: -20%\n\n"}
			break;

	}
	return _return;	
}


//helpers below

function found_path(_path, _char) {
	return string_pos(_char, _path) > 0;
}

function get_letter_title(_letters, _title, _field_index, _value) {
	for (var _i = 0; _i < array_length(_letters); _i ++) {
		if (_letters[_i].title == _title) {
			if (_field_index == -1) return true;
			var _fields = _letters[_i].fields;
			return (_field_index < array_length(_fields) && _fields[_field_index][1] == _value);
		}
	}
	return false;
}
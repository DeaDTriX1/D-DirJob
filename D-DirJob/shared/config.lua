dir             = {}

Config2                            = {
webhookDiscordfacture = 'https://discord.com/api/webhooks/1017949732972265553/QtuftII63LovGyk3rLwEbkbsn3fgOulQpjwFYV1i2QnEFhvU6yTHMXjmaSVb_Dd26vIb', -- Facture au joueur
webhookDiscordperso = 'https://discord.com/api/webhooks/1017949732972265553/QtuftII63LovGyk3rLwEbkbsn3fgOulQpjwFYV1i2QnEFhvU6yTHMXjmaSVb_Dd26vIb', -- Annonce personalisée
webhookDiscordouvert = 'https://discord.com/api/webhooks/1017949732972265553/QtuftII63LovGyk3rLwEbkbsn3fgOulQpjwFYV1i2QnEFhvU6yTHMXjmaSVb_Dd26vIb', -- Annonce D'ouverture
webhookDiscordfermer = 'https://discord.com/api/webhooks/1017949732972265553/QtuftII63LovGyk3rLwEbkbsn3fgOulQpjwFYV1i2QnEFhvU6yTHMXjmaSVb_Dd26vIb', -- Annonce de Fermeture
}


dir.Tarif = {
    {depannage = '~b~Remorquage',                montant = 500},
    {depannage = '~b~Crochetage Serrure',        montant = 200},
    {depannage = '~b~Réparation Véhicule',       montant = 500},
    {depannage = '~b~Néttoyage Véhicule',        montant = 200},

}


dir.jeveuxmarker = true --- true = Oui | false = Non

dir.jeveuxblips = true --- true = Oui | false = Non

dir.pos = {
	coffre = {
		position = {x = -336.03, y = -158.65, z = 44.58}
	},
	Vestiaire = {
		position = {x = -340.0, y = -162.34, z = 44.59}
	},
	garage = {
		position = {x = -343.55, y = -165.13, z = 39.01}
	},
	Fabrication = {
		position = {x = -322.79, y = -146.13, z = 39.02}
	},
	spawnvoiture = {
		position = {x = -357.75, y = -157.98, z = 38.72, h = 29.84}
	},
	deleteveh = {
		position = {x = -356.78, y = -159.05, z = 38.73}
	},
	boss = {
		position = {x = -339.96, y = -157.33, z = 44.58}
	},
	RDV = {
		position = {x = -358.83, y = -130.45, z = 38.7},
	},
	blips = {
		position = {x = -205.57, y = -1308.87, z = 31.29}
	},
}

Gdirvoiture = {
    {nom = "Dépanneuse", modele = "flatbed"},
}

dir.tenue = {
		male = {
        ['tshirt_1'] = 15, ['tshirt_2'] = 2,
        ['torso_1'] = 65, ['torso_2'] = 0,
        ['arms'] = 31,
        ['pants_1'] = 38, ['pants_2'] = 0,
        ['shoes_1'] = 12, ['shoes_2'] = 6,
		},
		female = {
        ['tshirt_1'] = 15,['tshirt_2'] = 2,
        ['torso_1'] = 65, ['torso_2'] = 2,
        ['arms'] = 36, ['arms_2'] = 0,
        ['pants_1'] = 38, ['pants_2'] = 2,
        ['shoes_1'] = 12, ['shoes_2'] = 6,
	}
}
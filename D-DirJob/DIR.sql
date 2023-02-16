INSERT INTO `addon_account` (name, label, shared) VALUES
    ('society_dir', 'dir', 1)
;

INSERT INTO `datastore` (name, label, shared) VALUES
    ('society_dir', 'dir', 1)
;

INSERT INTO `addon_inventory` (name, label, shared) VALUES 
    ('society_dir', 'dir', 1)
;

INSERT INTO `jobs` (name, label) VALUES
    ('dir', 'D.I.R')
;

INSERT INTO `job_grades` (job_name, grade, name, label, salary, skin_male, skin_female) VALUES
    ('dir',0,'recrue','Stagiaire',12,'{}','{}'),
    ('dir',1,'novice','Employee',24,'{}','{}'),
    ('dir',2,'experimente','Gérant',36,'{}','{}'),
    ('dir',3,'chief','Manager',48,'{}','{}'),
    ('dir',4,'boss','Boss',0,'{}','{}')
;

INSERT INTO `items` (`name`, `label`, `limit`) VALUES  
    ('kitrepa', 'Kit de réparation', 5),
    ('kitnettoyage', 'Kit de Néttoyage', 5)
;

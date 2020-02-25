-- 8. Quel sont les parties politiques qui dans leur libellé comporte le terme « Union »

SELECT libelle FROM nuancier WHERE libelle LIKE '%Union%';

-- 9. Quels élus du département du « var » sont nais entre le mois de juin et aout ?

SELECT nom, prenom, Date_de_naissance
FROM elus
JOIN villes ON elus.code_insee = villes.code_insee AND month(Date_de_naissance) BETWEEN 06 AND 08
JOIN departements ON villes.departement_code = departements.code
AND departements.name = 'var'; 

-- 10. Quel est l’âge moyen des élus homme au 01/01/2014 ? Celui des élus femme ?

SELECT sexe, AVG(timestampdiff(YEAR, Date_de_naissance, "2014-01-01")) Age_moyen
FROM elus
GROUP BY sexe; 

-- 11. Afficher la population totale du département des « Bouches-du-Rhône »

CREATE INDEX index_code (departements.code_) ; 

SELECT SUM(population_legale) AS pop_totale_BDR
FROM population
JOIN villes
ON villes.code_insee = population.code_insee
JOIN departements
ON villes.departement_code = departements.code
WHERE code_ = 13; 

-- 12. Quel sont les 10 départements comptant le plus d’ouvriers.

SELECT SUM(Ouvriers) AS somme_ouvriers, nom_normalise
FROM categorie C
JOIN villes V
ON V.code_insee = C.code
JOIN departements D ON D.code = V.departement_code
GROUP BY nom_normalise
ORDER BY Ouvriers DESC LIMIT 10;

-- 13. Afficher le nombre d’élus regrouper par nuance politique et par département.

CREATE INDEX idx_codeinsee_ ON elus (codeinsee_);
CREATE INDEX idx_nuance ON elus (nuance_de_la_liste); 
CREATE INDEX idx_departments ON villes (department_code);
CREATE INDEX idx_villes ON villes (code_insee);
CREATE INDEX idx_dep_name ON departments (name);

SELECT COUNT(nom) as nombre_elus, departments.name, nuancier.libelle 
FROM elus
JOIN villes
ON elus.codeinsee_ = villes.code_insee
JOIN departments
ON departments.code = villes.departement_code
JOIN nuancier
ON nuancier.code = elus.code_nuance_de_la_liste
GROUP BY nuancier.libelle, departments.name;

-- 14. Afficher le nombre d’élus regroupé par nuance politique et par villes pour le
-- département des « Bouches-du-Rhône ».

SELECT COUNT(nom) as nombre_elus, departments.name, nuancier.libelle 
FROM elus
JOIN villes
ON elus.codeinsee_ = villes.code_insee AND villes.department_code = "13"
JOIN nuancier
ON nuancier.code = elus.code_nuance_de_la_liste
-- WHERE departments.name = "Bouches-du-Rhône"
GROUP BY nuancier.libelle, villes.name;

-- 15. Afficher les 10 départements dans lesquelles il y a le plus d’élus femme, ainsi que le
-- nombre d’élus femme correspondant.

SELECT d.name, COUNT(sexe) AS nb_elus
FROM elus AS e
JOIN villes AS v 
ON e.code_insee = v.code_insee AND sexe = "F"
JOIN departments AS d ON v.department_code = d.code
GROUP BY d.name
ORDER BY nb_elus DESC LIMIT 10;

-- 16. Donner l’âge moyen des élus par départements au 01/01/2014. Les afficher par ordre
-- décroissant.

SELECT AVG(2013 - year(Date_de_naissance)) AS age
FROM elus
JOIN villes on elus.code_insee = villes.code_insee
JOIN departments ON villes.department_code = departments.code 
GROUP BY departments.name
ORDER BY age DESC; 

-- 17. Afficher les départements où l’âge moyen des élus est strictement inférieur à 54 ans.

SELECT AVG(2019 - year(Date_de_naissance)) AS age, Date_de_naissance, department_code
FROM elus 
JOIN villes ON elus.code_insee = villes.code_insee
GROUP BY department_code
HAVING AGE < 54
ORDER BY age;  
















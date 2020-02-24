-- Deuxième partie: Construire une base de données

-- 3. Créer une base de données « RNE » -- 
CREATE DATABASE RNE;
USE RNE;
-- 4. Y créer les tables destinées à accueillir les six fichiers cités plus haut. A vous de bien
-- choisir la longueur des champs et les types adéquate. Utilisez pour noms de colonnes
-- ceux renvoyer par r_names(). Le nom des tables doit être :
-- elus
-- population (La colonne population doit être en numérique)
-- nuancier
-- villes
-- categorie (Les colonnes doivent être numérique)
-- departements.
CREATE TABLE elus (
codeinsee varchar(30) comment "Code(insee)",
modedescrutin varchar(30)	comment "Mode de scrutin",
numliste varchar(14) comment	"Numéro de liste",	
codenuancedelaliste varchar(10)	comment "code(nuance de la liste)", 
numéroducandidantdanslaliste varchar(14) comment	"Numéro du candidat dans la liste",
tour varchar(10) comment	"Tour",
nom varchar(10) comment	"Nom",
prénom varchar(10) comment	"Prénom",
sexe varchar(5)	comment "Sexe",
datedenaissance varchar(50) comment 	"Date de naissance",
codeprofession varchar(50) comment	"Code(profession)",
libelle varchar(50) comment	"Libellé",
profession varchar(10) comment "Profession",
nationalite varchar(10) comment "Nationalité");

CREATE TABLE population ( 
code varchar(10) comment "Code",
Populationlegale integer(20) comment "Population légale");


CREATE TABLE nuancier (
code varchar(10) comment "Code",
libelle varchar(60) comment "Libellé",
ordre varchar(60) comment "Ordre",
definition varchar (500) comment "Définition");

CREATE TABLE villes (
id varchar(100) comment "ID",
departement_code varchar(100) comment "Code département",
code_insee varchar(100) comment "Code insee",
zip_code varchar(100) comment "Zip code",
name varchar(100) comment "Name");

CREATE TABLE categorie (
code varchar(50) comment "Code",
nb_demplois integer(30) comment "Nb d'emplois",
artisans integer(30) comment "Artisans",
commercants integer(30) comment "commerçants",
chefsdentreprise integer(30) comment "Chefs d'entreprise",
cadresetprofessionintellectuellessuperieures integer(30) comment "Cadres et professions supérieures intellectuelles",
professionintermediaires integer(30) comment "Profession intermédiaires",
employes integer(30) comment "Employés",
ouvriers integer(30) comment "Ouvriers");

CREATE TABLE departments (
id varchar(10) comment "ID",
region_code varchar(20) comment "Région code",
code varchar(20) comment "Code",
name varchar(20) comment "Name",
nomnormalise varchar(20) comment "Nom normalisé");

-- 5. Ecrire la requête qui va créer un nouvelle utilisateur MySQL « RNE_user » avec pour
-- mot de passe « RNE_pasword » et lui accorder tous les droits sur la base RNE. Utiliser
-- cette utilisateur pour la suite.-- 
CREATE USER 'RNE_user' IDENTIFIED BY 'RNE_password';
GRANT ALL ON RNE TO 'RNE_user';


-- Troisième partie : requêtes SQL

-- 8. Quel sont les parties politiques qui dans leur libellé comporte le terme « Union »

CREATE UNIQUE INDEX `index_id` ON `nuancier` (`libelle`);
SELECT libelle, definition FROM nuancier WHERE libelle = 'Liste Union de la Gauche'; 

-- 9. Quels élus du département du « var » sont nais entre le mois de juin et aout ?

CREATE UNIQUE INDEX `index_departments` ON `elus` (`id`, `codeinsee_`);

SELECT * 
FROM departments
JOIN elus ON departments.id = elus.codeinsee_;

SELECT name, nom, prenom, Date_de_naissance FROM departments WHERE name = Var;

-- Désolé j'ai pas pu faire plus par manque de temps.. 











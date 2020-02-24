#!/usr/bin/env python
# coding: utf-8

# In[1]:


# Correction: Projet_evaluation


# In[2]:


# 1. Ecrire une fonction python r_names() qui admet pour entrer une de ces chaînes de
  #caractères et qui retourne une liste de nom de colonnes.


# In[5]:


from re import sub #sub: fonction de substitution 


# In[6]:


names_elus = "code (insee)	mode de scrutin	numliste	code (nuance de la liste)	numéro du candidat dans la liste	tour	nom	prénom	sexe	Date de naissance	code (profession)	libellé profession	nationalité"


def r_names(names):

    names = names.split("\t") # Couper la chaine de caractère par rapport à la tabulation[\t] ou autre..

    for i, m in enumerate(names):
        m = m.replace("'", "_")
        m = m.replace(" ", "_")
        m = m.replace(".", "_")
        m = m.replace("é", "e")
        m = m.replace("(", "")
        m = m.replace(",", "")
        names[i] = m.replace(")", "")
        
        # replace est une méthode qui va remplacer les arguments entre guillemets par le nouvel argument 


        
    return names

print(r_names(names_elus))

#split est une méthode qu'on applique a une chaine de caractère avec plusieurs elements qu'on a changer en liste 


# In[9]:


#2. 2. Ecrire une fonction python parse_dates() qui admet pour entrer la liste renvoyer par
#r_names() et qui retourne une liste contenant seulement les noms de colonnes
#commençant par « Date».


# In[10]:


def parses_date(liste):
    l1 = " ".join(liste) # va prendre chaque element de la liste et va les joindre 
    
    l = findall("Date[^\s]*", l1) #findall: fonction de recherche
                                
    return l

    

print(parses_date(r_names(names_elus)))

#Autre méthode 

# x=r_names(elus)

#def parse_dates(x):
    #for i in range (0, len(x)):
        #if x[i][0:4] == 'Date':
        #y.append(x[i])
    #return y.append
        
#print(parses_dates(x))

#Autre méthode

#def parses_dates(x):

#return [i for i in x if i.startwith('Date')]


# In[ ]:


#Voir suite sur SQL


# 6. Les fichiers ayant la même structure, écrire une fonction chargement() pour alimenter
#la base « RNE » avec ces fichiers. Cette fonction utilisera les fonction r_names et
#parses_dates(). Elle aura pour entrer la chaîne de caractère contenant le nom des
#colonnes, le chemin d’accès vers le fichier et le nom de la table dans la quel écrire.
#Alimenter la base avec les fichiers.


from sqlalchemy import create_engine
import pandas as pd
import time


    
engine = create_engine("mysql+pymysql://misterheinz:simplon@localhost/RNE") 


def chargement(link, table, names):
    
    print("Lecture des données")
    
    names = r_names(names)
    date = parses_date(names)
    
    
    df = pd.read_excel(link ,
                       skiprows = [0,1],
                       header = None, names = names,
                       parses_date = date ) #header est l'entête et skiprows est le fait de sauter une ligne
    
    df.to_sql(table,
              con = engine,
              if_exists='append', #if_exists= Si il existe une table ajouté les données lui correspondant
              index = False) # Quand on met False, cela veut dire qu'on ajoute pas d'index dans la table SQL
        
    return print("fin")


# Autre méthode 

#municipal  =  r_names ( municipaux )
#nuances  =  r_names ( nuance_pol )
#ville  =  r_names ( villes )
#ref  =  r_names ( ref_geo_commune )
#pop  =  r_names ( population_commune )
#dep  =  r_names ( départements )

#print ( 'elus =' , municipal , ' \ n \ n ' , 'nuancier =' , nuances , ' \ n \ n ' , 'villes =' , ville , " \ n \ n " , 'catégorie =' , ref , ' \ n \ n ' , "population =" , pop , ' \ n \ n ' , 'départements =' ,dep )


#def  chargement ( s , chemin , table ):
    #name_cols  =  r_names ( s )
    #df  =  pd . read_excel ( path , delimiter = '|' , skiprows = 2 , names = name_cols , parse_dates  =  parse_dates ( s ))
    #df . to_sql ( table , con = engine , if_exists = 'append' , index = False )
    #retour  impression ( 'tableau' , tableau , 'a été rempli' )
    
#chargement ( municipaux , path_eval + 'elus_mun2014.xlsx' , 'elus' )    
#chargement ( nuance_pol , path_eval + 'codes_nuances.xlsx' , 'nuancier' )    
#chargement ( villes , path_eval + 'cities.xlsx' , 'villes' )  
#chargement ( ref_geo_commune , path_eval + 'categorie_professionelle.xlsx' , 'categorie' )  
#chargement ( population_commune , path_eval + 'population2017.xlsx' , 'population' )  
#chargement ( departements , path_eval + 'departements.xlsx' , 'departements')









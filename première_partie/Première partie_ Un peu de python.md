#!/usr/bin/env python
# coding: utf-8

# In[31]:


# Première partie: un peu de python
# 1. Pour chacun des six fichiers nous avons la liste de colonnes contenus dans une seule et unique
#chaîne de caractère. Vous trouverez l’ensemble de ces chaînes de caractères dans le fichier
#« Libellé des colonnes.txt ». Les noms des colonnes sont séparés par des tabulations :
#names_elus = « code (insee)
#mode de scrutin
#numliste
#code (nuance de la
#liste) numéro du candidat dans la liste
#tour
#nom prénom sexe Date de
#naissance
#code (profession)
#libellé profession
#nationalité »
#1. Ecrire une fonction python r_names() qui admet pour entrer une de ces chaînes de
#caractères et qui retourne une liste de nom de colonnes.

#Les espaces, les « ‘ » et les « . » doivent être remplacé par des « _ ».
#Les « é » et « è » doivent être remplacé par des « e ».
#Les « , », « ) » et « ( » doivent être supprimées.


# In[32]:


from re import findall


# In[33]:


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


        
    return names
print(r_names(names_elus))


# In[34]:


#2. Ecrire une fonction python parse_dates() qui admet pour entrer la liste renvoyer par
#r_names() et qui retourne une liste contenant seulement les noms de colonnes
#commençant par « Date».


# In[35]:



def parses_date(liste):
    l1 = " ".join(liste)
    
    l = findall("Date[^\s]*", l1)
    return l

    

print(parses_date(r_names(names_elus)))


# In[36]:


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


# In[76]:


names_categorie = "code	nb_demplois	artisans	commercants	chefsdentreprise	cadresetprofessionintellectuellessupérieures	professionintermédiaires	employes	ouvriers"

chargement("/home/yacine/Bureau/Projet_examen/categorie_professionelle.xlsx","categorie",  names_categorie)


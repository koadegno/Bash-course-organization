# bash_project

- run : ./project1.sh courses.txt dir_source dir_destination

- explication :  Le script va créer, dans le dossier 'dir_destination', un dossier 'University',qui
  contient autant de sous-dossiers qu’il y a de cours suivis. 
  Il effectuera en-suite deux recherches 
  dans le répertoire 'dir_source' (et ses sous-dossiers) : une recherche dans les noms
  de fichiers et une recherche dans le contenu des fichiers. 
  Les mots clés à rechercher sont les noms des cours. (voir pdf) 
  Les fichiers trouvés seront copiés dans le dossier correspondant, 
  et un log sera écrit dans unfichierlog.outdans le dossier de 'University'.

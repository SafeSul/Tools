#!/usr/bin/bash

# PARAMETROS DE ENTRADA:
# 1 - DOMÍNIO RAIZ

#Variaveis utilizadas nas funcoes:
file=vivos.txt
file2=dominios.txt

#Cria/acessa pasta para armazenar resultados
dominio=$1
path=$dominio'_'$(date +"%F_%T")
mkdir $path
cd $path

# Realiza reconhecimento de subdominios
recon() {
        dominio=$1
        echo "Executando subfinder $dominio"
        subfinder -silent -d $dominio >> $file

        echo "Executando assetfinder $dominio"
        assetfinder $dominio >> $file

        #echo "Executando amass $dominio"
        #amass enum -silent -d $dominio >> $file

        echo "Executando findomain $dominio"
        findomain -q -t $dominio >> $file 2>/dev/null

        ordena_arquivo $file
        cat $file > $file2
}

remove_repetidos(){
        echo "Removendo dominios repetidos"
        cat $1 | uniq > tmp_file
        cat tmp_file > $1
        rm -r tmp_file
}

ordena_arquivo() {
        echo "Ordenando arquivo $1"
        cat $1 | sort -u > tmp_file
        cat tmp_file > $1
        rm -r tmp_file
}

httpx_vivos(){
        echo "Verificando dominios vivos"
        cat $file2 | httpx -silent -threads 100 > $file
}

go_witness(){
        #Para cada dominio vivo, tira um print
        cat $1 | httpx -silent -threads 100 > tmp_file
        echo "Executando gowitness"
        gowitness file -f tmp_file --disable-logging --disable-db
        rm -rf tmp_file
}

httpx_banner_grabbing(){
        echo "Executando banner-grabbing httpx dominios"
        cat $1 | httpx -threads 100 -title -status-code -tech-detect -silent > banner_domains.txt
}

nabbu_func(){
        while read d;
        do
              naabu -host $d -silent -nmap-cli 'nmap -sS -sV' -o naabu_$d.txt
        done < $file
}

nuclei_func(){
        nuclei -update-templates -silent
        nuclei -l $file2 -silent  -t ~/nuclei-templates/ &> nuclei.txt
}

#Executa o reconhecimento no dominio base
recon $1

#Executa reconhecimento de subdominios para todos dominios encontrados no recon inicial
#while read d;
#do
#        recon $d
#done < $file

#Executa gowitness na lista de subdominios
#go_witness $file

#Executa banner grabbing
#httpx_banner_grabbing $file

#Ordena e remove repetidos
#ordena_arquivo $file

# Naabu para scan de portas
echo "Naabu"
#nabbu_func


# Nuclei para analise de vulnerabilidades
echo "Comecando Nuclei"
nuclei_func
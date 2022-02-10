#!/usr/bin/env bash
#
# sefaznfe.discovery.sh - Realiza o download da página do serviço de NFE da receita federal
#
# Site:         https://medium.com/@bernardolankheet/monitorando-status-de-servi%C3%A7o-nfe-da-sefaz-com-zabbix-c2ecfdbbfb72
# GitHub:       https://github.com/alexandremjcastro/
# Autor:        Bernado Lankheet
# Manutenção:   Alexandre Castro
#
# ------------------------------------------------------------------------ #
#  - Realiza o download da página e salva em /tmp com o nome statusNFE.txt.
#  Se ele tiver sucesso no download ele retorna o valor 1, caso tenha falha ou
#  a página estiver offline ele retorna 0.
#
#   Exemplos:
#      $ ./sefaznfe.discovery.sh http://www.nfe.fazenda.gov.br/portal/disponibilidade.aspx?versao=0.00&tipoConteudo=Skeuqr8PQBY=
#      Neste exemplo o script realiza o download do link, se o resultado for 1
#      significa que o download da página foi feito com sucesso e armaenando dentro do /tmp.
#      Caso o valor for 0 houve alguma falha no download.
# ------------------------------------------------------------------------ #
# Histórico:
#
#   v1.0 07/11/2019, Alexandre:
#     - Adcionado cabeçalho e comentários ao script. E Adcionado a opção -k no comando curl.
#
# ------------------------------------------------------------------------ #
# Testado em:
#   bash 4.2.46
# ------------------------------- VARIÁVEIS ----------------------------------------- #
CURL=$(which curl)
AWK=$(which awk)
CAT=$(which cat)
EGREP=$(which egrep)
LINK=$1 # Link tem que ser adicionado na macro do host no zabbix.
ARQUIVO_TEMPORARIO="/tmp/statusNFE.txt" # Local onde será salvo as informações da página
# ------------------------------- EXECUÇÃO ----------------------------------------- #
# Download do link fornecido.
if $CURL -b 'session=' -s -k -o $ARQUIVO_TEMPORARIO "$LINK"; then
echo "1" # Download realizado com sucesso
else
echo "0" # Falha ao realizar o download
fi

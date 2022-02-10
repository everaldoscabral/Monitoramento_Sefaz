#!/usr/bin/env bash
#
# sefaznfe.consulta.sh - Consulta o status do serviço de NFE da receita federal
#
# GitHub:       https://github.com/alexandremjcastro/
# Autor:        Alexandre Castro
# Manutenção: -
#
# ------------------------------------------------------------------------ #
#  - Este programa irá consultar o status do serviço de NFE da receita federal
#  Responsável por realizar a consulta dentro do arquivo statusNFE.txt,
#  nas consultas será pesquisada as linhas do Autorizador e cada linha de serviço
#  deste autorizador, nesse script ele verificará as alterações das “Bolinhas”
#  em cada serviço, se for verde (Disponível) ele apresentará o resultado 1, 2
#  para amarelo (Indisponível) e 0 para Vermelho(Offine).
#
#  - Script criado com base no script do @bernardolankheet.
#
#   Exemplos:
#      $ ./sefaznfe.consulta.sh AM AUTORIZACAO
#      Neste exemplo o script realiza a consulta do campo de "Autorização" do
#      estado de AM. Retornando o valor 1, 2 ou 0.
# ------------------------------------------------------------------------ #
# Histórico:
#
#   v1.0 07/11/2019, Alexandre:
#     - Script criado.
#
# ------------------------------------------------------------------------ #
# Testado em:
#   bash 4.2.46
# ------------------------------- VARIÁVEIS ----------------------------------------- #
CURL=$(which curl)
AWK=$(which awk)
CAT=$(which cat)
ESTADO=$1
STATUS=$2
# ------------------------------- FUNÇÕES ----------------------------------------- #
# Status dos estados
function consultar_servico() {
        [[ $STATUS_AUTORIZACAO == "imagens/bola_verde_P.png" ]] && echo "1" #DISPONIVEL
        [[ $STATUS_AUTORIZACAO == "imagens/bola_amarela_P.png" ]] && echo "2" #INDISPONIVEL
        [[ $STATUS_AUTORIZACAO == "imagens/bola_vermelho_P.png" ]] && echo "0" #OFFLINE
        [[ $STATUS_RETORNO_AUTORIZACAO == "imagens/bola_verde_P.png" ]] && echo "1" #DISPONIVEL
        [[ $STATUS_RETORNO_AUTORIZACAO == "imagens/bola_amarela_P.png" ]] && echo "2" #INDISPONIVEL
        [[ $STATUS_RETORNO_AUTORIZACAO == "imagens/bola_vermelho_P.png" ]] && echo "0" #OFFLINE
        [[ $STATUS_INUTILIZACAO == "imagens/bola_verde_P.png" ]] && echo "1" #DISPONIVEL
        [[ $STATUS_INUTILIZACAO == "imagens/bola_amarela_P.png" ]] && echo "2" #INDISPONIVEL
        [[ $STATUS_INUTILIZACAO == "imagens/bola_vermelho_P.png" ]] && echo "0" #OFFLINE
        [[ $STATUS_CONSULTA_PROTOCOLO == "imagens/bola_verde_P.png" ]] && echo "1" #DISPONIVEL
        [[ $STATUS_CONSULTA_PROTOCOLO == "imagens/bola_amarela_P.png" ]] && echo "2" #INDISPONIVEL
        [[ $STATUS_CONSULTA_PROTOCOLO == "imagens/bola_vermelho_P.png" ]] && echo "0" #OFFLINE
        [[ $STATUS_CONSULTA_PROTOCOLO2 == "imagens/bola_verde_P.png" ]] && echo "1" #DISPONIVEL
        [[ $STATUS_CONSULTA_PROTOCOLO2 == "imagens/bola_amarela_P.png" ]] && echo "2" #INDISPONIVEL
        [[ $STATUS_CONSULTA_PROTOCOLO2 == "imagens/bola_vermelho_P.png" ]] && echo "0" #OFFLINE
        [[ $STATUS_SERVICO == "imagens/bola_verde_P.png" ]] && echo "1" #DISPONIVEL
        [[ $STATUS_SERVICO == "imagens/bola_amarela_P.png" ]] && echo "2" #INDISPONIVEL
        [[ $STATUS_SERVICO == "imagens/bola_vermelho_P.png" ]] && echo "0" #OFFLINE
        [[ $STATUS_SERVICO2 == "imagens/bola_verde_P.png" ]] && echo "1" #DISPONIVEL
        [[ $STATUS_SERVICO2 == "imagens/bola_amarela_P.png" ]] && echo "2" #INDISPONIVEL
        [[ $STATUS_SERVICO2 == "imagens/bola_vermelho_P.png" ]] && echo "0" #OFFLINE
        [[ $STATUS_CONSULTA_CADASTRO == "imagens/bola_verde_P.png" ]] && echo "1" #DISPONIVEL
        [[ $STATUS_CONSULTA_CADASTRO == "imagens/bola_amarela_P.png" ]] && echo "2" #INDISPONIVEL
        [[ $STATUS_CONSULTA_CADASTRO == "imagens/bola_vermelho_P.png" ]] && echo "0" #OFFLINE
        [[ $STATUS_RECEPCAO_EVENTO == "imagens/bola_verde_P.png" ]] && echo "1" #DISPONIVEL
        [[ $STATUS_RECEPCAO_EVENTO == "imagens/bola_amarela_P.png" ]] && echo "2" #INDISPONIVEL
        [[ $STATUS_RECEPCAO_EVENTO == "imagens/bola_vermelho_P.png" ]] && echo "0" #OFFLINE
        [[ $STATUS_RECEPCAO_EVENTO2 == "imagens/bola_verde_P.png" ]] && echo "1" #DISPONIVEL
        [[ $STATUS_RECEPCAO_EVENTO2 == "imagens/bola_amarela_P.png" ]] && echo "2" #INDISPONIVEL
        [[ $STATUS_RECEPCAO_EVENTO2 == "imagens/bola_vermelho_P.png" ]] && echo "0" #OFFLINE
        [[ $STATUS_RECEPCAO_EVENTO3 == "imagens/bola_verde_P.png" ]] && echo "1" #DISPONIVEL
        [[ $STATUS_RECEPCAO_EVENTO3 == "imagens/bola_amarela_P.png" ]] && echo "2" #INDISPONIVEL
        [[ $STATUS_RECEPCAO_EVENTO3 == "imagens/bola_vermelho_P.png" ]] && echo "0" #OFFLINE
}
# ------------------------------- EXECUÇÃO ----------------------------------------- #
# Arquivo com as informações da página.
ARQUIVO_TEMPORARIO="/tmp/statusNFE.txt"

# Verificar o status dos estados
if [[ $ESTADO,$STATUS == @(AM|BA|CE|GO|MG|MS|MT|PE|PR|RS|SP|SVAN|SVRS|SVC-AN|SVC-RS),AUTORIZACAO ]]; then
  STATUS_AUTORIZACAO=$($CAT $ARQUIVO_TEMPORARIO | egrep "<td>$ESTADO</td>" | $AWK '{print $2}' | $AWK -F 'src="' '{print $2}'| $AWK -F '"' '{print $1}') && consultar_servico
    elif [[ $ESTADO,$STATUS == @(AM|BA|CE|GO|MG|MS|MT|PE|PR|RS|SP|SVAN|SVRS|SVC-AN|SVC-RS),RETORNO.AUT ]]; then
      STATUS_RETORNO_AUTORIZACAO=$($CAT $ARQUIVO_TEMPORARIO | egrep "<td>$ESTADO</td>" | $AWK '{print $4}' | $AWK -F 'src="' '{print $2}'| $AWK -F '"' '{print $1}') && consultar_servico
        elif [[ $ESTADO,$STATUS == @(AM|BA|CE|GO|MG|MS|MT|PE|PR|RS|SP|SVAN|SVRS),INUTILIZACAO ]]; then
          STATUS_INUTILIZACAO=$($CAT $ARQUIVO_TEMPORARIO | egrep "<td>$ESTADO</td>" | $AWK '{print $6}' | $AWK -F 'src="' '{print $2}'| $AWK -F '"' '{print $1}') && consultar_servico
            elif [[ $ESTADO,$STATUS == @(AM|BA|CE|GO|MG|MS|MT|PE|PR|RS|SP|SVAN|SVRS),CONSULTA.PROTOCOLO ]]; then
              STATUS_CONSULTA_PROTOCOLO=$($CAT $ARQUIVO_TEMPORARIO | egrep "<td>$ESTADO</td>" | $AWK '{print $8}' | $AWK -F 'src="' '{print $2}'| $AWK -F '"' '{print $1}') && consultar_servico
            elif [[ $ESTADO,$STATUS == @(SVC-AN|SVC-RS),CONSULTA.PROTOCOLO ]]; then
              STATUS_CONSULTA_PROTOCOLO2=$($CAT $ARQUIVO_TEMPORARIO | egrep "<td>$ESTADO</td>" | $AWK '{print $6}' | $AWK -F 'src="' '{print $2}'| $AWK -F '"' '{print $1}') && consultar_servico
                elif [[ $ESTADO,$STATUS == @(AM|BA|CE|GO|MG|MS|MT|PE|PR|RS|SP|SVAN|SVRS),SERVICO ]]; then
                  STATUS_SERVICO=$($CAT $ARQUIVO_TEMPORARIO | egrep "<td>$ESTADO</td>" | $AWK '{print $10}' | $AWK -F 'src="' '{print $2}'| $AWK -F '"' '{print $1}') && consultar_servico
                elif [[ $ESTADO,$STATUS == @(SVC-AN|SVC-RS),SERVICO ]]; then
                  STATUS_SERVICO2=$($CAT $ARQUIVO_TEMPORARIO | egrep "<td>$ESTADO</td>" | $AWK '{print $8}' | $AWK -F 'src="' '{print $2}'| $AWK -F '"' '{print $1}') && consultar_servico
                    elif [[ $ESTADO,$STATUS == @(BA|CE|GO|MG|MS|MT|PE|PR|RS|SP|SVRS),CONSULTA.CADASTRO ]]; then
                      STATUS_CONSULTA_CADASTRO=$($CAT $ARQUIVO_TEMPORARIO | egrep "<td>$ESTADO</td>" | $AWK '{print $12}' | $AWK -F 'src="' '{print $2}'| $AWK -F '"' '{print $1}') && consultar_servico
                        elif [[ $ESTADO,$STATUS == @(BA|CE|GO|MG|MS|MT|PE|PR|RS|SP|SVRS),RECEPCAO.EVENTO ]]; then
                          STATUS_RECEPCAO_EVENTO=$($CAT $ARQUIVO_TEMPORARIO | egrep "<td>$ESTADO</td>" | $AWK '{print $14}' | $AWK -F 'src="' '{print $2}'| $AWK -F '"' '{print $1}') && consultar_servico
                        elif [[ $ESTADO,$STATUS == @(AM|SVAN),RECEPCAO.EVENTO ]]; then
                          STATUS_RECEPCAO_EVENTO2=$($CAT $ARQUIVO_TEMPORARIO | egrep "<td>$ESTADO</td>" | $AWK '{print $12}' | $AWK -F 'src="' '{print $2}'| $AWK -F '"' '{print $1}') && consultar_servico
                        elif [[ $ESTADO,$STATUS == @(SVC-AN|SVC-RS),RECEPCAO.EVENTO ]]; then
                          STATUS_RECEPCAO_EVENTO3=$($CAT $ARQUIVO_TEMPORARIO | egrep "<td>$ESTADO</td>" | $AWK '{print $10}' | $AWK -F 'src="' '{print $2}'| $AWK -F '"' '{print $1}') && consultar_servico
else
  echo "5" #SEM DADOS
fi

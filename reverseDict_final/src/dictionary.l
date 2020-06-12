%{
#include "y.tab.h"
%}
%option noyywrap
%option yylineno

acentos    \xc3[\x80-\xbf]       
letra      [a-zA-Z]|{acentos}
simbolos   [\-()/':]
texto      {letra}|{simbolos}

%x DICT WORD

%%
.|\n                                       ;                /* consome tudo sem retornar até encontrar o __BEGIN__*/
__BEGIN__                                  {BEGIN(DICT);}        /* inicializa o modo reconhecedor do dicionário*/
<DICT>^{letra}                             {yylval.texto=strdup(yytext);return(id);}
<DICT>^{letra}{texto}+(" "{texto}+)*       {yylval.texto=strdup(yytext);return(palavra);} /* reconhece tokens de palavras, permitindo apenas um espaço entre as strings*/
<DICT>^" "/({letra}|-)                     {BEGIN(WORD);}
<DICT>{letra}{texto}*(" "{texto}+)*        {yylval.texto=strdup(yytext);return(traducao);}
<DICT>[ \t\n]                              ;                 /* consome espaços e tabulações desncessárias*/
<DICT>.                                    {return yytext[0];}/* retorna todos os tokens de símbolo único, pode gerar erros de sintaxe, mas esse comportamento é desejado.*/
<WORD>-                                    {return yytext[0];}
<WORD>" "                                  ;
<WORD>{letra}{texto}+(" "{letra}{texto}+)* {yylval.texto=strdup(yytext);return(subitem);}
<WORD>[ ]{2}                               {BEGIN(DICT);}
<WORD>.                                    {printf("Errorss:%s\n", yytext);}


%%
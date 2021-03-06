/* Compiler Theory and Design
   Dr. Duane J. Jarc */

/* This file contains flex input file */

%{
#include <cstdio>
#include <string>

using namespace std;

#include "listing.h"
#include "tokens.h"

%}

%option noyywrap

ws			[ \t\r]+
comment		\-\-.*\n
line		[\n]
id			[A-Za-z][A-Za-z0-9_]+[A-Za-z0-9]$
digit		[0-9]
int			{digit}+
punc		[\(\),:;]
singlecomment		"//"[^\n]*
real		[0-9]+.[0-9]+([eE]{1}([+-]{1})?[0-9]+)?
%%

{ws}		{ ECHO; }
{comment}	{ ECHO; nextLine();}
{singlecomment}	{ECHO; nextLine();}
{line}		{ ECHO; nextLine();}

"<"			{ ECHO; return(RELOP); }
"+"			{ ECHO; return(ADDOP); }
"-"			{ ECHO; return(ADDOP); }
"*"			{ ECHO; return(MULOP); }
"/"			{ ECHO; return(MULOP); }
"rem"		{ ECHO; return(REMOP); }
"**"		{ ECHO; return(EXPOP); }


"=>"		{ ECHO; return(ARROW); }
"="			{ ECHO; return(RELOP); }
"/="		{ ECHO; return(RELOP); }
">"			{ ECHO; return(RELOP); }
">="		{ ECHO; return(RELOP); }
"<="		{ ECHO; return(RELOP); }

true		{ ECHO; return(BOOL_LITERAL); }
false		{ ECHO; return(BOOL_LITERAL); }


begin		{ ECHO; return(BEGIN_); }
boolean		{ ECHO; return(BOOLEAN); }
end			{ ECHO; return(END); }
endreduce	{ ECHO; return(ENDREDUCE); }
function	{ ECHO; return(FUNCTION); }
integer		{ ECHO; return(INTEGER); }
is			{ ECHO; return(IS); }
reduce		{ ECHO; return REDUCE; }
returns		{ ECHO; return(RETURNS); }
and			{ ECHO; return(ANDOP); }
case		{ ECHO; return(CASE); }
else		{ ECHO; return(ELSE); }
endcase		{ ECHO; return(ENDCASE); }
endif		{ ECHO; return(ENDIF); }
if			{ ECHO; return(IF); }
others		{ ECHO; return(OTHERS); }
real		{ ECHO; return(REAL); }
then		{ ECHO; return(THEN); }
when		{ ECHO; return(WHEN); }
{id}		{ ECHO; return(IDENTIFIER);}
{int}		{ ECHO; return(INT_LITERAL); }
{real}		{ECHO; return(REAL_LITERAL); }
{punc}		{ ECHO; return(yytext[0]); }
.			{ ECHO; appendError(LEXICAL, yytext); }
%%

int main()
{
	firstLine();
	
	FILE *file = fopen("lexemes.txt", "wa"); 
	int token = yylex();
	while (token)
	{
		fprintf(file, "%d\n", token);
		token = yylex();
	}
	lastLine();
	fclose(file);
	return 0;
}

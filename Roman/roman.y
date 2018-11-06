%{
# include <stdio.h>
int yylex();
int yyparse();
%}

%output "roman.tab.c"

/* its token time */
%token I V X L C D M
%token EOL

%%

calclist: /* nothing */ 	{}
 | calclist romanNum EOL 			{printf("%d\n", $2);}
 ;

romanNum: thousand hundo ten digit	{$$ = $1 + $2 + $3 + $4;}
 |hundo ten digit			{$$ = $1 + $2 + $3;}
 |ten digit					{$$ = $1 + $2;}
 |digit						{$$ = $1;}
 ;

thousand: {$$ = 0;}
 |M {$$ = 1000;}
 |M M {$$ = 2000;}
 |M M M {$$ = 3000;}
 ;

hundo: shundo	{$$ = 0;}
 |{$$ = $1;}
 |C D		{$$ = 400;}
 |D shundo	{$$ = 500 + $2;}
 |C M		{$$ = 900;}
 ;

shundo:	C	 {$$ = 0;}
 |{$$ = 100;}
 |C C		{$$ = 200;}
 |C C C		{$$ = 300;}
 ;

ten: sten	 {$$ = 0;}
 |{$$ = $1;}
 |X L		{$$ = 40;}
 |L sten	{$$ = 50 + $2;}
 |X C		{$$ = 90;}
 ;

sten: X			{$$ = 0;}
 |{$$ = 10;}
 |X X		{$$ = 20;}
 |X X X		{$$ = 30;}
 ;

digit: sdigit	{$$ = 0;}
 |{$$ = $1;}
 |I V		{$$ = 4;}
 |V sdigit	{$$ = 5 + $2;}
 |I X		{$$ = 9;}
 ;

sdigit: I		{$$ = 0;}
 |{$$ = 1;}
 |I I		{$$ = 2;}
 |I I I		{$$ = 3;}
 ;

%%
void yyerror(char *s){
  printf("%s\n", s);
}

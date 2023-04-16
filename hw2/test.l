%{
/*정의절의 시작*/
#include <stdio.h>
int preprocessornum=0;//전처리기의 개수를 의미
int octalnum=0;//8진수의 개수를 의미
int negadecnum=0;//10진수 중 음수를 의미
int postdecnum=0;//10진수 중 양수를 의미
int operatornum=0;//연산자의 개수를 의미
int commentnum=0;//주석의 개수를 의미
int equalnum=0;//'='의 개수를 의미
int leftcurlybracenum=0;//'{'의 개수를 의미
int rightcurlybracenum=0;//'}'의 개수를 의미
int wordcase1=0;//p가 2번만 들어간 단어의 개수를 의미
int wordcase2=0;//e로 시작하고 마지막 글자가 m인 단어의 개수를 의미
int word=0;//그 이외의 단어 개수를 의미
int mark=0;//위에서 포함되지 않는 단어의 개수를 의미
%}
%%
	/*규칙절 정의 시작*/
#include|#define	{preprocessornum++;}
\{	{leftcurlybracenum++;}
\}	{rightcurlybracenum++;}
0[0-9]+	{octalnum++;}
-[0-9]+	{negadecnum++;}//음수
[0-9]+	{postdecnum++;}
\/{2}.*	{commentnum++;}
\/\*(\n)*.*(\n)*\*\/	{commentnum++;}
%[a-z]	{operatornum++;word++;}
\+|-|\*|%	{operatornum++;}//산술연산자
\|\||&&|!	{operatornum++;}//논리연산자
==|!=	{operatornum++;}//관계연산자
\+\+|--	{operatornum++;}
,	{operatornum++;}
\*|&	{operatornum++;}
\[[0-9]+\]	{mark+=3;}
[a-zA-Z]*p[a-zA-Z]*p[a-zA-Z]*p[a-zA-Z]*	{word++;}
[a-zA-Z]*p[a-zA-Z]*p[a-zA-Z]*	{wordcase1++;}
e[a-zA-Z]*m	{wordcase2++;}
=	{equalnum++;}
[a-zA-Z]+	{word++;} 
\n	;
.	{mark++;}
%%
int main()
{
	yylex();
	printf("preprocessor =  %d\n",preprocessornum);
	printf("octal number = %d\n",octalnum);
	printf("negative decimal number = %d\n",negadecnum);
	printf("positive decimal number = %d\n",postdecnum);
	printf("operator = %d\n",operatornum);
	printf("comment = %d\n",commentnum);
	printf("'=' = %d\n",equalnum);
	printf("'{' = %d\n",leftcurlybracenum);
	printf("'}' = %d\n",rightcurlybracenum);
	printf("wordcase1 = %d\n",wordcase1);
	printf("wordcase2 = %d\n",wordcase2);
	printf("word = %d\n",word);
	printf("mark = %d\n",mark);
	return 0;
}
int yywrap()
{
	return 1;
}

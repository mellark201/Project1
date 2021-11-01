// Compiler Theory and Design
// Dr. Duane J. Jarc

// This file contains the bodies of the functions that produces the compilation
// listing

#include <cstdio>
#include <string>

using namespace std;

#include "listing.h"

static int lineNumber;
static queue<string> queue;
static int totalErrors = 0;
static int lexicalErrors = 0;
static int semanticErrors = 0;
static int syntaxErrors = 0;

static void displayErrors();

void firstLine()
{
	lineNumber = 1;
	printf("\n%4d  ",lineNumber);
}

void nextLine()
{
	displayErrors();
	lineNumber++;
	printf("%4d  ",lineNumber);
}

int lastLine()
{
	printf("\r");
	displayErrors();
	printf("     \n");
	printf("Lexical Errors : %d", lexicalErrors);
	printf("Syntax Errors : %d", syntaxErrors);
	printf("Semantic Errors : %d", semanticErrors);
	return totalErrors;
}
    
void appendError(ErrorCategories errorCategory, string message)
{
	string messages[] = { "Lexical Error, Invalid Character ", "",
		"Semantic Error, ", "Semantic Error, Duplicate Identifier: ",
		"Semantic Error, Undeclared " };
	if(errorCategory == ErrorCategories.LEXICAL)
		lexicalErrors++;
	else if(errorCategory == ErrorCategories.SYNTAX)
		syntaxErrors++;
	else if(errorCategory == ErrorCategories.GENERAL_SEMANTIC)
		semanticErrors++;

	error = messages[errorCategory] + message;
	queue.push(error);
	totalErrors++;
}

void displayErrors()
{
	// if (error != "")
	// 	printf("%s\n", error.c_str());
	// error = "";
	while(queue.size()>0) {
		printf("%s\n", queue.front().c_str());
		queue.pop();
	}
}

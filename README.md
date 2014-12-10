<h2>Use run.sh to compile. </h2>

<h2>Run ./a.out  "input program" </h2>

Phase 1 - Was done using flex and bison. It took some effort to get the grammar correct and shift-reduce/reduce-reduce error free. 

Flex is a tool which generates a program for lexical analysis. We specified the tokens that were allowed in our grammar in flex and the program it generated matched it in the order in with the tokens were present to a token. It in effect, gives us a getnexttoken() function which just gives the next token found in the input.

Bison is a tool which generates a parser. We need the specify our grammar rules for which bison generated a LR1 parser. It does, left to right, rightmost derivation, bottom up parsing using 1 lookahead symbol. This look-ahead is obtained by the getnexttoken() function given to us by fles.

Phase 2
First we implemented a nested class structure for Decaf Language. Our AST actually consists of three different trees, each for variable and field declarations, expressions and for statements. Each consists of a main class and several other derived class types as per the requirements of the grammar. Then we merged the class structure with Phase 1 code i.e. in bison code.

For code generation, we used the Builder object of LLVM, which is a helper object that makes it easy to generate LLVM instructions. We used Instances of the `IRBuilder <http://llvm.org/doxygen/IRBuilder_8h-source.html>`_ class to keep track of where to insert instructions and it also had the methods to create new instructions. 





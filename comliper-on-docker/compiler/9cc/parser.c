#include "9cc.h"
Node *code[100];

typedef struct Lvar Lvar;
struct Lvar {
  Lvar *next;
  char *name;
  int len;
  int offset;
};

Lvar *locals = NULL;
Lvar *find_lvar(Token *tok);

// 新しいノードを作成して、型と左辺、右辺を代入する
Node *new_node(NodeKind kind, Node *lhs, Node *rhs){
  Node *node = calloc(1, sizeof(Node));
  node->kind = kind;
  node->lhs = lhs;
  node->rhs = rhs;
  return node;
}

Node *new_node_num(int val){
  Node *node = calloc(1, sizeof(Node));
  node->kind = ND_NUM;
  node->val = val;
  return node;
}

Lvar *new_lvar(Token *tok){
  Lvar *lvar = calloc(1, sizeof(Lvar));
  lvar->name = tok->str;
  lvar->len = tok->len;

  if (locals){
    lvar->offset = locals->offset + 8;
    locals->next = lvar;
  } else {
    lvar->offset = 8;
    locals = lvar;
  }
  return lvar;
}

bool equal_assign_str(Token *tok, Lvar *var) {
  return var->len == tok->len && !memcmp(tok->str, var->name, var->len);
}

Lvar *find_lvar(Token *tok){
  for (Lvar *var = locals; var; var = var->next){
    if (equal_assign_str(tok, var)){
      return var;
    }
  }
  return NULL;
}

/*

文法規則
program    = stmt*
stmt       = expr ";" | "return" expr ";"
expr       = assign
assign     = equality ("=" assign)?
equality   = relatinal ("==" relational | "!=" relational)*
relational = add ("<" add | "<=" add | ">" add | ">=" add)
add        = mul ("+" mul | "-" mul)*
mul        = unary ("*" unary | "/" unary)*
unary      = ("+" | "-")? term
term       = num | ident | "(" expr ")"

*/

// program    = stmt*
void program(){
  int i = 0;
  while (!at_eof()){
    code[i] = stmt();
    i++;
  }
  code[i] = NULL;
}

// stmt       = expr ";" | "return" expr ";"
Node *stmt() {
  Node *node;

  if (consume_return(TK_RETURN)){
    node = calloc(1, sizeof(Node));
    node->kind = ND_RETURN;
    node->lhs = expr();
  } else {
    node = expr();
  }

  if (!consume(";")){
    error_at(token->str, "';'が抜けています");
  }
  return node;
}

// expr       = assign
Node *expr(){
  return assign();
}

// assign     = equality ("=" assign)?
Node *assign(){
  Node *node = equality();

  if (consume("=")) {
    node = new_node(ND_ASSIGN, node, assign());
  }
  return node;
}

// equality   = relatinal ("==" relational | "!=" relational)*
Node *equality(){
  Node *node = relational();

  for (;;) {
    if (consume("==")) {
      node = new_node(ND_EQ, node, relational());
    } else if (consume("!=")) {
      node = new_node(ND_NE, node, relational());
    } else {
      return node;
    }
  }
}

// relational = add ("<" add | "<=" add | ">" add | ">=" add)
Node *relational() {
  Node *node = add();

  for (;;) {
    if (consume("<")) {
      node = new_node(ND_LT, node, add());
    } else if (consume("<=")) {
      node = new_node(ND_LE, node, add());
    } else if (consume(">")) {
      node = new_node(ND_LT, add(), node);
    } else if (consume(">=")) {
      node = new_node(ND_LE, add(), node);
    } else {
      return node;
    }
  }
}

//  add        = mul ("+" mul | "-" mul)*
Node *add() {
  Node *node = mul();

  for (;;){
    if (consume("+")) {
      node = new_node(ND_ADD, node, mul());
    } else if(consume("-")){
      node = new_node(ND_SUB, node, mul());
    } else{
      return node;
    }
  }
}

// mul        = unary ("*" unary | "/" unary)*
Node *mul(){
  Node *node = unary();

  for (;;){
    if (consume("*")){
      node = new_node(ND_MUL, node, unary());
    }else if(consume("/")){
      node = new_node(ND_DIV, node, unary());
    }else{
      return node;
    }
  }
}

// unary      = ("+" | "-")? term
Node *unary(){
  if (consume("+")){
    return term();
  }
  if (consume("-")){
    return new_node(ND_SUB, new_node_num(0), term());
  }
  return term();
}

// term       = num | ident | "(" expr ")"
Node *term(){
  if (consume("(")){
    Node *node = expr();
    expect(")");
    return node;
  }

  Token *tok = consume_ident();
  if (tok){
    Node *node = calloc(1, sizeof(Node));
    node->kind = ND_LVAR;

    Lvar *lvar = find_lvar(tok);
    if (lvar){
      node->offset = lvar->offset;
    } else {
      lvar = new_lvar(tok);
      node->offset = lvar->offset;
    } 
    return node;
  }

  // 再帰的なconsume()を実行した結果、どの演算子にも該当しなければ数字のはず
  return new_node_num(expect_number());
}

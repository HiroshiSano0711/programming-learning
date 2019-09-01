#include "9cc.h"

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

/*

文法規則
program    = stmt*
stmt       = expr ";"
expr       = assign
assign     = equality ("=" assign)?
equality   = relatinal ("==" relational | "!=" relational)*
relational = add ("<" add | "<=" add | ">" add | ">=" add)
add        = mul ("+" mul | "-" mul)*
mul        = unary ("*" unary | "/" unary)*
unary      = ("+" | "-")? term
term       = num | ident | "(" expr ")"

*/

Node *code[100];

// program    = stmt*
void program(){
  int i = 0;
  while (!at_eof()){
    code[i] = stmt();
    i++;
  }
  code[i] = NULL;
}

// stmt       = expr ";"
Node *stmt() {
  Node *node = expr();
  expect(";");
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

  // identの処理
  Token *tok = consume_ident();
  if (tok){
    Node *node = calloc(1, sizeof(Node));
    node->kind = ND_LVAR;
    node->offset = (tok->str[0] - 'a' +1) * 8;
    return node;
  }

  // 再帰的なconsume()を実行した結果、どの演算子にも該当しなければ数字のはず
  return new_node_num(expect_number());
}

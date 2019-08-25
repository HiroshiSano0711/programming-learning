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

// EBNF expr = mul ("+" mul | "-" mul)* のコード化
Node *expr(){
  Node *node = mul();

  for (;;){
    if (consume('+')){ // consume()関数でtoken->nextを実行しているので+の次のトークンを指す
      node = new_node(ND_ADD, node, mul());
    }else if(consume('-')){
      node = new_node(ND_SUB, node, mul());
    }else{
      return node;
    }
  }
}

// EBNF mul = term ("*" term | "/" term)* のコード化
Node *mul(){
  Node *node = unary();

  for (;;){
    if (consume('*')){
      node = new_node(ND_MUL, node, unary());
    }else if(consume('/')){
      node = new_node(ND_DIV, node, unary());
    }else{
      return node;
    }
  }
}

Node *unary(){
  if (consume('+')){
    return term();
  }
  if (consume('-')){
    return new_node(ND_SUB, new_node_num(0), term());
  }
  return term();
}

// EBNF term = "(" expr ")" | num のコード化
Node *term(){
  if (consume('(')){
    Node *node = expr();
    expect(')');
    return node;
  }
  return new_node_num(expect_number());
}

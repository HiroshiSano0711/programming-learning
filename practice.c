#include <stdio.h>

// typedef int * intPtr_t;

// typedef struct {
//   char name[20];
//   char sex;
//   int age;
//   double height;
//   double weight;
// } person_t;
//
// int main(int argc, char const *argv[]){
//   person_t p = {"Tom", 'M', 19, 175.2, 69.5};

//   printf("%s %c %d %f %f\n", p.name, p.sex, p.age, p.height, p.weight);
//   p.age ++;
//   p.height += 0.7;
//   p.weight += 1.5;
//   printf("%s %c %d %f %f\n", p.name, p.sex, p.age, p.height, p.weight);
//   return 0;
// }

// struct syain_dt {
//   long no;
//   char name[20];
//   char yaku[20];
//   int nensu;
//   struct kyuuyo {
//     long kihon;
//     long jyutaku;
//     long kazoku;
//     long sikaku;
//   } kyu;
// };

// int main(int argc, char const *argv[]){
//   struct syain_dt shomu[20] = {
//     {78027, "直樹", "課長", 21, 346780, 10000, 15000, 12000},
//     {78027, "直樹", "課長", 21, 346780, 10000, 15000, 12000},
//     {0, "", "",  0, 0, 0, 0, 0}
//   };

//   int i;

//   for(i = 0; shomu[i].no!=0; i++) {
//     printf("%ld \n", shomu[i].kyu.kihon);
//     printf("%ld \n", shomu[i].kyu.jyutaku);
//     printf("%ld \n", shomu[i].kyu.kazoku);
//     printf("%ld \n", shomu[i].kyu.sikaku);

//     printf("%s 総支給額 = %ld\n",
//       shomu[i].name,
//       shomu[i].kyu.kihon + shomu[i].kyu.jyutaku +
//       shomu[i].kyu.kazoku + shomu[i].kyu.sikaku
//     );
//   }
  
//   return 0;
// }

struct performance {
  int no;
  char name[20];
  double average;
};

int main(){
  int i;
  struct performance student[20] = {
    {1, "HIROPON1", 89.3},
    {2, "HIROPON2", 50.5},
    {3, "HIROPON3", 75.6},
  };

  struct performance *p;
  p = student;

  for(i = 0; i < 3; i++){
    printf("%s\n", (p + i)->name);
  }

  for(i = 0; i < 3; i++){
    printf("%s\n", p->name);
    ++p;
  }

  return 0;
}

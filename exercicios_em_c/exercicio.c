
#include <stdio.h>
#include <stdlib.h>
#include <string.h>


int main() 
{
  int n1, n2 = 0;

  printf("Digite um numero \n");
  scanf("%d", &n1);
  printf("Digite outro numero \n");
  scanf("%d", &n2);

  
  if(n1 > n2){
    printf("\n%d é o numero maior\n",n1);
  }
  else if(n2 > n1){
    printf("\n%d é o numero maior\n",n2);
  }
  else{
    printf("\nos numeros são iguais\n");
  }

  return 0;
}
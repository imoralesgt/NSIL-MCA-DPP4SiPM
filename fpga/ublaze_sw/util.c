
#include "xil_types.h"
#include <string.h>
#include "util.h"

int u32toa(u32 n, char *str)
   {
   char buf[30];
   int i, counter = 0;

   if (n == 0)
      buf[counter++] = '0';

   for ( ; n; n /= 10)
      buf[counter++] = "0123456789"[n%10];

   for (i = 0; i < counter; ++i)
      str[i] = buf[counter - i - 1];

   str[counter] = 0;
   return counter;
   }

int u32atoa(u32 *array, int len, char *str)
   {
   int i,ld,la = 0;
   char *pc;

   pc = str;
   for(i=0;i<len;i++)
	  {
	  ld = u32toa(array[i], pc);
	  pc += ld;
	  *pc = ' ';
	  pc++;
	  la += ld;
	  la++;
	  }
   la--;
   pc--;
   *pc='\0';
   return la;
   }

u32 atou32(char* str)
   {
   int res = 0;
   char c;

   for (int i = 0; str[i] != '\0'; ++i)
	  {
	  c = str[i];
	  if(c == ' ') continue;
      res = res * 10 + c - '0';
	  }

   return res;
   }

int atoi32(char* str)
   {
   int res = 0;
   int inv = 0;
   char c;

   for (int i = 0; str[i] != '\0'; ++i)
	  {
	  c = str[i];
	  if(c == ' ')  continue;
	  if(c == '-')
		 {
		 inv = 1;
		 continue;
		 }
      res = res * 10 + c - '0';
	  }
   // return result.
   if(inv) return -res;
   else return res;
   }


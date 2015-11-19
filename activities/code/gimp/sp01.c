#include <stdio.h>
#include <stdlib.h>
#define guint   unsigned int
#define guint8  unsigned char

static const struct {
  guint  	 width;
  guint  	 height;
  guint  	 bytes_per_pixel; /* 2:RGB16, 3:RGB, 4:RGBA */ 
  guint8 	 pixel_data[8 * 8 * 3 + 1];
} gimp_image = {
  8, 8, 3,
  "\0\0\0\0\0\0\0\0\0\377aa\377aa\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\377aa\377aa"
  "\377aa\377aa\0\0\0\0\0\0\0\0\0\377aa\377aa\377aa\377aa\377aa\377aa\0\0\0"
  "\377aa\377aa\361\350[\377aa\377aa\361\350[\377aa\377aa\377aa\377aa\377aa"
  "\377aa\377aa\377aa\377aa\377aa\0\0\0\0\0\0\356::\0\0\0\0\0\0\356::\0\0\0"
  "\0\0\0\0\0\0\356::\0\0\0\356::\356::\0\0\0\356::\0\0\0\356::\0\0\0\356::"
  "\0\0\0\0\0\0\356::\0\0\0\356::",
};

int main() {
    for (int i=0;i<gimp_image.width * gimp_image.height * 3;i++) {
        if (i!=0) { printf(","); }
        printf("%d",gimp_image.pixel_data[i]);
    }

    printf("\n");

return 1;
}

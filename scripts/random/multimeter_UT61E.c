#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <termios.h>
#include <stdio.h>
#include <string.h>
#include <sys/ioctl.h>

#define BAUDRATE B2400            

#define MODEMDEVICE "/dev/ttyUSB0"

#define _POSIX_SOURCE 1 /* POSIX compliant source */

#define FALSE 0
#define TRUE 1

volatile int STOP=FALSE; 

/*
 * Stuff we know about:
 */
unsigned int Valid=1;
unsigned int Hold,Rel, Rms, Overflow, Valid;
float Digit;
char UnitS[10];
enum kinda_unit {V, A, Hz, C, MOhm};
enum kinda_unit Unit;

unsigned char buf[255];
unsigned char digit_lookup[] = "0123456789L____ ";



main()
{
  int fd,c, res;
  unsigned int mcr;
  struct termios newtio;
/* 
 * Open modem device for reading and writing and not as controlling tty
 * because we don't want to get killed if linenoise sends CTRL-C.
 *
 */
 fd = open(MODEMDEVICE, O_RDONLY | O_NOCTTY ); 
 if (fd <0) {perror(MODEMDEVICE); return(-1); }

 bzero(&newtio, sizeof(newtio));

 newtio.c_cflag = BAUDRATE | CS8 | CLOCAL | CREAD ;
 newtio.c_iflag = ICRNL;
 newtio.c_oflag = 0;
 newtio.c_lflag = ~ICANON;

 newtio.c_cc[VINTR]    = 0;     /* Ctrl-c */ 
 newtio.c_cc[VQUIT]    = 0;     /* Ctrl-\ */
 newtio.c_cc[VERASE]   = 0;     /* del */
 newtio.c_cc[VKILL]    = 0;     /* @ */
 newtio.c_cc[VEOF]     = 0;     /* Ctrl-d */
 newtio.c_cc[VTIME]    = 1;     /* inter-character timer unused */
 newtio.c_cc[VMIN]     = 14;     /* blocking read until 1 character arrives */
 newtio.c_cc[VSWTC]    = 0;     /* '\0' */
 newtio.c_cc[VSTART]   =17;     /* Ctrl-q */ 
 newtio.c_cc[VSTOP]    =19;     /* Ctrl-s */
 newtio.c_cc[VSUSP]    = 0;     /* Ctrl-z */
 newtio.c_cc[VEOL]     = 0;     /* '\0' */
 newtio.c_cc[VREPRINT] = 0;     /* Ctrl-r */
 newtio.c_cc[VDISCARD] = 0;     /* Ctrl-u */
 newtio.c_cc[VWERASE]  = 0;     /* Ctrl-w */
 newtio.c_cc[VLNEXT]   = 0;     /* Ctrl-v */
 newtio.c_cc[VEOL2]    = 0;     /* '\0' */


 tcsetattr(fd,TCSANOW,&newtio);
 mcr = 0;
 ioctl(fd,TIOCMGET,&mcr);
 mcr &= ~TIOCM_RTS;
 mcr |= TIOCM_DTR;
 ioctl(fd,TIOCMSET,&mcr);

 tcflush(fd, TCIFLUSH);

 while (STOP==FALSE) {
    res = read(fd,buf,255); 
    Valid = 0;
    Digit = 0.0;
    Overflow = 0;

    if (res==14){
       if(buf[13]==0x0A) {
          Valid=1;
       } else {
         printf("Sycning:");
         do {
           read(fd,buf,1); 
           printf(".");
         } while (buf[0]!=0x0A);
         printf("\n");
       }
    }

    if(Valid==1){
#if 0
	printf("Dump:");
	for(c=0; c<14; c++)
	{
		printf("0x%2.2X ", buf[c]);
	}
	printf("\n");
#endif

	/* Display Value */
        if(buf[0] & 0x04) printf("-"); 
        printf("%c", digit_lookup[buf[1]&0x0f]);
        if(buf[6] & 0x01) printf("."); 
        printf("%c", digit_lookup[buf[2]&0x0f]);
        if(buf[6] & 0x02) printf("."); 
        printf("%c", digit_lookup[buf[3]&0x0f]);
        if(buf[6] & 0x04) printf("."); 
        printf("%c", digit_lookup[buf[4]&0x0f]);

	/* Multipler */
	printf(" ");
        if(buf[8] & 0x02) printf("n"); 
        if(buf[9] & 0x10) printf("M"); 
        if(buf[9] & 0x20) printf("k"); 
        if(buf[9] & 0x40) printf("m"); 
        if(buf[9] & 0x80) printf("u"); 

	/* Units */
        if(buf[9] & 0x02) printf("\% "); 
        if(buf[10] & 0x01) printf("'F "); 
        if(buf[10] & 0x02) printf("'C "); 
        if(buf[10] & 0x04) printf("F "); 
        if(buf[10] & 0x08) printf("Hz "); 
        if(buf[10] & 0x20) printf("Ohm "); 
        if(buf[10] & 0x40) printf("A "); 
        if(buf[10] & 0x80) printf("V "); 

	/* AC/DC */
        if(buf[7] & 0x08) printf("AC "); 
        if(buf[7] & 0x10) printf("DC "); 

	/* Hold, Min, Max */
	if (buf[8] & 0x30 || buf[7] & 0x26) {
	printf("(");
        if(buf[7] & 0x02) printf("Hold "); 
        if(buf[7] & 0x04) printf("REL "); 
        if(buf[7] & 0x20) printf("Auto "); 
        if(buf[8] & 0x10) printf("Min "); 
        if(buf[8] & 0x20) printf("Max "); 
	printf("\b)");
	}

	printf("\n");
  };
 };
}

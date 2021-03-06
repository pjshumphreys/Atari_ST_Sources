#include <osbind.h>
#include <stdio.h>
#include <stdlib.h>

int main()
{
	unsigned char key;
	while(key=getch()!='\33')
	{
		switch(key)
		{
			
		}
	}
	dir();
	getch();
	return(0);
}

typedef struct
{
	unsigned char	format,
					res1,
					name[18],
					disk_id[2],
					res2,
					format_type[2],
					res3,
					res4[229];
}CBM_Header;

typedef struct
{
	unsigned char	free_sectors,
	                sectors[5];
}BAM_Data;

typedef struct
{
	unsigned char	dos,
	                version,
					disk_id[2],
	                res1;
}CBM_BAM;

typedef struct
{
	unsigned char	type,
					start_track,
					start_sector,
					name[16],
					rel_1,
					rel_2,
					rel_3,
					res,
					year,
					month,
					day,
					hour,
					min,
					size_l,
					size_h;
}Files_data;

typedef struct
{
	Files_data		f1;
	unsigned char   r1[2];
	Files_data		f2;
	unsigned char   r2[2];
	Files_data		f3;
	unsigned char   r3[2];
	Files_data		f4;
	unsigned char   r4[2];
	Files_data		f5;
	unsigned char   r5[2];
	Files_data		f6;
	unsigned char   r6[2];
	Files_data		f7;
	unsigned char   r7[2];
	Files_data		f8;
}CBM_Files;

typedef struct
{
	unsigned char	next_track,
					next_sector;
	union
	{
		unsigned char	d[254];
        CBM_Header		h;
        CBM_BAM			b;
        CBM_Files		f;
	};
}CBM_Sector;

static CBM_Sector  hs;
void printdiskname(CBM_Header *h)
{
	int i;
	unsigned char disk_name[17];
	strncpy(disk_name,h->name,16);
	disk_name[16]=0;
	for (i=0; i<16; i++)
		if(disk_name[i]==0xA0)
			disk_name[i]=' ';
  
	printf("      \"%s\" %c%c%c%c%c\n",disk_name,h->disk_id[0],h->disk_id[1],h->res2,h->format_type[0],h->format_type[1]);
	printf("-----------------------------------------\n");
}

void dir()
{
	CBM_Sector s;
	int track=40,sector=3;
	cbm_read(&s,40,0);
	printdiskname(&s.h);
	do
	{
		cbm_read(&s,track,sector);
		printfile(&s.f.f1);
		printfile(&s.f.f2);
		printfile(&s.f.f3);
		printfile(&s.f.f4);
		printfile(&s.f.f5);
		printfile(&s.f.f6);
		printfile(&s.f.f7);
		printfile(&s.f.f8);
		track=s.next_track;
		sector=s.next_sector;
	}while(track!=0);
}

void printfile(Files_data *f)
{
	int i;
	unsigned char file_name[17];
	strncpy(file_name,f->name,16);
	file_name[16]=0;
    if(*(f->name)==0)
      return;
	for (i=0; i<16; i++)
		if(file_name[i]==0xA0)
			file_name[i]=' ';
	printf("%-5d \"%s\" ",(f->size_h<<8)+f->size_l,file_name);
	switch(f->type)
	{
		case 0x80:
		case 0x00:
		case 0xC00:
			printf("DEL\n");
			break;
		case 0x81:
		case 0x01:
		case 0xC1:
			printf("SEQ\n");
			break;
		case 0x82:
		case 0x02:
		case 0xC2:
			printf("PRG\n");
			break;
		case 0x83:
		case 0x03:
		case 0xC3:
			printf("USR\n");
			break;
		case 0x84:
		case 0x04:
		case 0xC4:
			printf("REL\n");
			break;
		case 0x85:
		case 0x05:
		case 0xC5:
			printf("CBM\n");
			break;
		case 0x86:
		case 0x06:
		case 0xC6:
			printf("DIR\n");
			break;
		default:
			printf("%d\n",f->type);
	}
}
















//************************************************************
//************************************************************
void cbm_read(void *memory,int cbm_track,int cbm_sector)
{
   unsigned char buffert[512];
   int fel=0;
   int track,sector,side;
   track=cbm_track -1;
   sector=((cbm_sector %20 ) >> 1) +1;
   side= cbm_sector/20 ;
   if(side==1)
     side=0;
   else
     side=1;
   fel=Floprd(buffert,0,0,sector,track,side,1);
   if(fel<0)
   {
     printf("\nERROR: %d while reading %d %d",fel,cbm_track,cbm_sector);
     printf("\n       real %d %d %d\n",track,sector,side);
   }
   
   if(cbm_sector &1)
     memcpy(memory,buffert+256,256);
   else
     memcpy(memory,buffert,256);
}

//************************************************************
//************************************************************
void cbm_write(void *memory,int cbm_track,int cbm_sector)
{
   unsigned char buffert[512];
   int fel=0;
   int track,sector,side;
   track=cbm_track -1;
   sector=((cbm_sector %20 ) >> 1) +1;
   side= cbm_sector/20 ;
   if(side==1)
     side=0;
   else
     side=1;
   fel=Floprd(buffert,0,0,sector,track,side,1);
   if(fel<0)
   {
     printf("\nERROR: %d while reading %d %d %d",fel,track,sector,side);
     return;
   }
   
   if(cbm_sector &1)
     memcpy(buffert+256,memory,256);
   else
     memcpy(buffert,memory,256);

   fel=Flopwr(buffert,0,0,sector,track,side,1);
   if(fel<0)
   {
     printf("\nERROR: %d while writing %d %d",fel,cbm_track,cbm_sector);
     printf("\n       real %d %d %d\n",track,sector,side);
   }
   
}
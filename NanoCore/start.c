/*Hanbings 3219065882@qq.com*/

#include "type.h"
#include "stdio.h"
#include "const.h"
#include "protect.h"
#include "string.h"
#include "fs.h"
#include "proc.h"
#include "tty.h"
#include "console.h"
#include "global.h"
#include "proto.h"


/*======================================================================*
                            cstart
 *======================================================================*/
PUBLIC void cstart()
{
	printfInfoNotReturn();
	disp_str("Boot Loader                                        \n");
	printfInfoNotReturn();
	disp_str("Loader loaded\n");
	printfInfoNotReturn();
	disp_str("NanoOS [Blue] Build 19/12/29 Version 191229.04.null\n");

	/* 将 LOADER 中的 GDT 复制到新的 GDT 中 */
	memcpy(	&gdt,				   /* New GDT */
		(void*)(*((u32*)(&gdt_ptr[2]))),   /* Base  of Old GDT */
		*((u16*)(&gdt_ptr[0])) + 1	   /* Limit of Old GDT */
		);
	/* gdt_ptr[6] 共 6 个字节：0~15:Limit  16~47:Base。用作 sgdt 以及 lgdt 的参数。 */
	u16* p_gdt_limit = (u16*)(&gdt_ptr[0]);
	u32* p_gdt_base  = (u32*)(&gdt_ptr[2]);
	*p_gdt_limit = GDT_SIZE * sizeof(struct descriptor) - 1;
	*p_gdt_base  = (u32)&gdt;

	/* idt_ptr[6] 共 6 个字节：0~15:Limit  16~47:Base。用作 sidt 以及 lidt 的参数。 */
	u16* p_idt_limit = (u16*)(&idt_ptr[0]);
	u32* p_idt_base  = (u32*)(&idt_ptr[2]);
	*p_idt_limit = IDT_SIZE * sizeof(struct gate) - 1;
	*p_idt_base  = (u32)&idt;

	init_prot();

	printfInfoNotReturn();
	disp_str("NanoOS [Blue] NanoCore (C) 2019 NanoZero | Hanbings 3219065882@qq.com    \n");
	printfInfoNotReturn();
	disp_str("NanoCore [Beta] NanoCore Will Be Better                                  \n");
	printfInfoNotReturn();
	disp_str("NanoCore Loading ...\n");
	//显示版本信息
	disp_str("\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n");
	printfInfoNotReturn();
	disp_str("NanoOS [Blue] Build 19/12/29 Version 191229.04.null\n");
	printfWarnNotReturn();
	disp_str("This Version is a Beta Version\n");
	printfInfoNotReturn();
	disp_str("My Github: https://github.com/hanbings/NanoOS\n");
}

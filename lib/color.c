/*Hanbings 3219065882@qq.com*/
#include "color.h"
/*懒得include*/
void disp_color_str(char * info, int color);

/*打印INFO函数*/
void printfInfo()
{
    disp_color_str("[INFO]\n",blackBrightGreenColor);
}
void printfWarn()
{
    disp_color_str("[WARN]\n",blackYellowColor);
}
void printfErro()
{
    disp_color_str("[ERRO]\n",blackBrightBrightRedColor);
}
/*打印INFO不回车*/
void printfInfoNotReturn()
{
    disp_color_str("[INFO]",blackBrightGreenColor);
}
void printfWarnNotReturn()
{
    disp_color_str("[WARN]",blackYellowColor);
}
void printfErroNotReturn()
{
    disp_color_str("[ERRO]",blackBrightBrightRedColor);
}
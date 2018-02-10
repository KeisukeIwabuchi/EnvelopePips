//+------------------------------------------------------------------+
//|                                                 EnvelopePips.mq4 |
//|                                 Copyright 2018, Keisuke Iwabuchi |
//|                                        https://order-button.com/ |
//+------------------------------------------------------------------+
#property copyright "Copyright 2018, Keisuke Iwabuchi"
#property link      "https://order-button.com/"
#property version   "1.00"
#property strict
#property indicator_chart_window
#property indicator_buffers 3
#property indicator_color1 C'76,175,80'
#property indicator_color2 C'76,175,80'
#property indicator_color3 C'76,175,80'
#property indicator_width1 1
#property indicator_width2 1
#property indicator_width3 1
#property indicator_style1 0
#property indicator_style2 0
#property indicator_style3 0

#include <mql4_modules\Price\Price.mqh>

input double Pips      = 10;
input int    ma_period = 20;

double upper[];
double lower[];
double middle[];

double pips;

int OnInit()
{
   IndicatorBuffers(3);
   SetIndexStyle(0, DRAW_LINE);
   SetIndexStyle(1, DRAW_LINE);
   SetIndexStyle(2, DRAW_LINE);
   SetIndexBuffer(0, upper);
   SetIndexBuffer(1, lower);
   SetIndexBuffer(2, middle);
   SetIndexLabel(0, "upper line");
   SetIndexLabel(1, "lower line");
   SetIndexLabel(2, "middle line");
   IndicatorDigits(Digits);
   
   pips = Price::PipsToPrice(Pips);
   
   return(INIT_SUCCEEDED);
}


int OnCalculate(const int rates_total,
                const int prev_calculated,
                const datetime &time[],
                const double &open[],
                const double &high[],
                const double &low[],
                const double &close[],
                const long &tick_volume[],
                const long &volume[],
                const int &spread[])
{
   int limit = Bars - IndicatorCounted();
   
   for (int i = limit - 1; i >= 0; i--) {
      middle[i] = iMA(_Symbol, 0, ma_period, 0, MODE_SMA, PRICE_CLOSE, i);
      upper[i] = middle[i] + pips;
      lower[i] = middle[i] - pips;
   }

   return(rates_total);
}

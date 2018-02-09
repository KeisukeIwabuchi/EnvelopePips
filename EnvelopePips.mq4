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
#property indicator_buffers 2
#property indicator_color1 clrBlue
#property indicator_color2 clrRed
#property indicator_width1 1
#property indicator_width2 1
#property indicator_style1 0
#property indicator_style2 0



input double Pips = 5;
input int    ma_period = 20;

double upper[];
double lower[];

int mult;

int OnInit()
{
   IndicatorBuffers(2);
   SetIndexStyle(0, DRAW_LINE);
   SetIndexStyle(1, DRAW_LINE);
   SetIndexBuffer(0, upper);
   SetIndexBuffer(1, lower);
   SetIndexLabel(0, "upper shadow line percentage");
   SetIndexLabel(1, "lower shadow line percentage");
   IndicatorDigits(Digits);
   
   mult = (_Digits == 3 || _Digits == 5) ? 10 : 1;
   
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
   double ma;
   int limit = Bars - IndicatorCounted();
   
   for (int i = limit - 1; i >= 0; i--) {
      ma = iMA(_Symbol, 0, ma_period, 0, MODE_SMA, PRICE_CLOSE, i);
      upper[i] = ma + Pips * Point * mult;
      lower[i] = ma - Pips * Point * mult;
   }

   return(rates_total);
}

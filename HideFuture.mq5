//+------------------------------------------------------------------+
//|                                                   HideFuture.mq5 |
//|                                  Copyright 2023, MetaQuotes Ltd. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2023, TRM Systems (Pty) Ltd"
#property version   "1.00"
#property description "This utility hides future price action. "
#property description "Use F12 for bar replay."

#include <Canvas\Canvas.mqh>
//+------------------------------------------------------------------+
//| Indicator properties                                             |
//+------------------------------------------------------------------+
#property indicator_chart_window
#property indicator_plots   0
//+------------------------------------------------------------------+
//| Input parameters                                                 |
//+------------------------------------------------------------------+
input int      xCordinates=955;
input int      yCordinates=0;
input int      Width=1100;
input int      Height=950;
input color    brgColor = clrWhite;
//+------------------------------------------------------------------+
//| global variables                                                 |
//+------------------------------------------------------------------+
CCanvas      canvas;
//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//+------------------------------------------------------------------+
int OnInit()
  {
  //--- check
   if(Width<100 || Height<100)
     {
      Print("Invalid width or height. Must be greater than 100");
      return(INIT_FAILED);
     }
//--- indicator buffers mapping
   if(!canvas.CreateBitmapLabel("HideCanvas",xCordinates,yCordinates,Width,Height,COLOR_FORMAT_ARGB_RAW))
     {
      Print("Error creating canvas: ",GetLastError());
      return(INIT_FAILED);
     }
//--- succeed
//---
   return(INIT_SUCCEEDED);
  }
  
  //+------------------------------------------------------------------+
//| Custom indicator deinitialization function                       |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
  {
   canvas.Destroy();
   ChartRedraw(0);
  }
  
//+------------------------------------------------------------------+
//| Custom indicator iteration function                              |
//+------------------------------------------------------------------+
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
//---
   //--- drawing
   canvas.Erase(ColorToARGB(brgColor, 255));
   canvas.Update(true);
//--- return value of prev_calculated for next call
   return(rates_total);
  }
//+------------------------------------------------------------------+

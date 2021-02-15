/*
** Vitali Droujko
** simpleMovingAverage.mq5
** 05/02/21
** calculate simple moving average
*/

#property copyright "Copyright 2020, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property version   "1.00"
#include <Trade\Trade.mqh>
CTrade trade;

void OnTick()
  {
   double myMovingAverageArray[];
   int movingAverageDefinition = iMA(_Symbol, _Period, 20, 0, MODE_SMA, PRICE_CLOSE);
   
   CopyBuffer(movingAverageDefinition, 0, 0, 3, myMovingAverageArray);
   float myMovingAverage20 = myMovingAverageArray[1];
   Comment ("MyMovingAverage20: ", myMovingAverage20);
  }


/*
** Vitali Droujko
** simpleBuyTrade.mq5
** 05/02/21
** simple buy trade (buy when the second candle is bullish)
*/

#property copyright "Copyright 2020, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property version   "1.00"
#include <Trade\Trade.mqh>
CTrade trade;

void OnTick()
  {
   double Ask = NormalizeDouble(SymbolInfoDouble(_Symbol, SYMBOL_ASK), _Digits);
   MqlRates PriceInfo[];
   
   ArraySetAsSeries(PriceInfo, true); // sort the price array from the current candle downwards
   
   int PriceDate = CopyRates(_Symbol, _Period, 0, 3, PriceInfo); //fill the array with price data
   
   if (PriceInfo[1].close > PriceInfo[1].open)
   {
      if (PositionsTotal() == 0)
      {
      trade.Buy(0.10, NULL, Ask, Ask - 300 * _Point, Ask + 150 * _Point, NULL);
      }
   }
  }

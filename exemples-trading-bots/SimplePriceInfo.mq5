#property copyright "Copyright 2020, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict

void OnTick()
  {
   MqlRates PriceInformation[]; //Create an Array
   ArraySetAsSeries(PriceInformation, true); //Sort it from current candle to oldes candle
   int Data = CopyRates(Symbol(), Period(), 0, Bars(Symbol(), Period()), PriceInformation); //Copy price into array
   
   if (PriceInformation[1].close > PriceInformation[2].close)
   {
      Comment("ca passe");
   }

  }
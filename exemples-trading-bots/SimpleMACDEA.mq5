#property copyright "Copyright 2020, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property version   "1.00"
#include<Trade\Trade.mqh>

CTrade trade;
void OnTick()
  {
  double Ask = NormalizeDouble(SymbolInfoDouble(_Symbol, SYMBOL_ASK), _Digits);
  double Bid = NormalizeDouble(SymbolInfoDouble(_Symbol, SYMBOL_BID), _Digits);
  
  string signal = "";
  double myPriceArray[];
  
  int MacDDefinition = iMACD(_Symbol, _Period, 12, 26, 9, PRICE_CLOSE);
  //_symbol -> la paire
  //_period -> la periode de la paire
  //Fast EMA
  //Slow EMA (exponentiel moving average)
  //MACD SMA (simple moving average)
  //calcul en fonction du prix de fermeture
  
  CopyBuffer(MacDDefinition, 0, 0, 3, myPriceArray);
  
  float MacDValue = (myPriceArray[0]);
  // get the value of current candle
  
  if (MacDValue>0)
   signal="sell";
  if (MacDValue<0)
   signal="buy";
  
  if (signal == "sell" && PositionsTotal()<1)
   trade.Sell(0.10,NULL,Bid,(Bid+200*_Point),(Bid-150*_Point), NULL);
   //sell 10 microlot
  if (signal == "buy" && PositionsTotal()<1)
   trade.Buy(0.10,NULL,Ask,(Ask-200*_Point),(Ask+150*_Point), NULL);
   //buy 10 Microlot
  Comment ("The signal is now: ", signal);
  }


//setChartColorBackground(clrBlack)
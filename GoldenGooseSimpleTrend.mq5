#property copyright "Copyright 2020, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict
#import "CheckTrend.mq5"

double Trend168hour;
int buyticket;

void OnTick()
  {
  Trend168hour = CheckTrend();
  if (OrdersTotal() == 0)
      if (Trend168hour > 0)
      {
         buyticket = OrderSend(Symbol(), OP_BUY, 0.01, Ask, 3, 0, (Ask + 0.01), NULL, 26082014, 0, Green);
         WindowScreenShot("Screenshot.gif", 1024, 600);
      }
  }
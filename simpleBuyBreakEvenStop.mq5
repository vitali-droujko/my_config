#include <Trade\Trade.mqh>
CTrade trade;

void CheckBuyBreakEvenStop(double Ask)
{
   for (int i = PositionsTotal() - 1; i >= 0; i--)
   {
      ulong PositionTicket = PositionGetInteger(POSITION_TICKET);
      double PositionBuyPrice = PositionGetDouble(POSITION_PRICE_OPEN);
      double PositionStopLoss = PositionGetDouble(POSITION_SL);
      double PositionTakeProfit = PositionGetDouble(POSITION_TP);
      double PositionType = PositionGetInteger(POSITION_TYPE);
      string symbol = PositionGetSymbol(i);
      if (_Symbol == symbol) {
         if (POSITION_TYPE_BUY == PositionType) {
            if (PositionStopLoss < PositionBuyPrice) {
               if (Ask > (PositionBuyPrice+50*_Point))
                  trade.PositionModify(PositionTicket, PositionBuyPrice+50*_Point, PositionTakeProfit);
               else if (Ask < (PositionBuyPrice-50*_Point))
                  trade.PositionModify(PositionTicket, PositionStopLoss+10*_Point, PositionTakeProfit);
            }        
         }           
      }
   }
}

void OnTick()
{
   double Ask = NormalizeDouble(SymbolInfoDouble(_Symbol, SYMBOL_ASK), _Digits);
   if (PositionsTotal() == 0)
   {
      trade.Buy(0.10, NULL, Ask, Ask-100*_Point, Ask+100*_Point, NULL);
   }
   CheckBuyBreakEvenStop(Ask);     
}

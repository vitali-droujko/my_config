#include<Trade\Trade.mqh>
CTrade trade;

void OnTick()
  {
	// create an empty String
   string entry ="";
	  
   // Get the Ask price
   double Ask=NormalizeDouble(SymbolInfoDouble(_Symbol,SYMBOL_ASK),_Digits); 
   
   // Get the Bid price
   double Bid=NormalizeDouble(SymbolInfoDouble(_Symbol,SYMBOL_BID),_Digits);       
      
   // We create an array for the prices
	MqlRates PriceInfo[]; 
   
   // We sort the price array from the current candle downwards
   ArraySetAsSeries(PriceInfo,true);   
   
   // We fill the array with the price data
   int PriceData =CopyRates(Symbol(),Period(),0,3,PriceInfo); 	

   // create an Array for several prices
   double UpperBandArray[];
   double LowerBandArray[];


   // sort the price array from the current candle downwards
   ArraySetAsSeries(UpperBandArray,true); 
   ArraySetAsSeries(LowerBandArray,true);
           
   // define Bollinger Bands 
   int BollingerBandsDefinition=iBands(_Symbol,_Period,20,0,2,PRICE_CLOSE);
   
   // Copy price info into the array
   CopyBuffer(BollingerBandsDefinition,1,0,3,UpperBandArray);
   CopyBuffer(BollingerBandsDefinition,2,0,3,LowerBandArray);
   
   // calculate EA for the current candle
   double myUpperBandValue=UpperBandArray[0];
   double myLowerBandValue=LowerBandArray[0];       
     
   // calculate EA for the candle before
   double myLastUpperBandValue=UpperBandArray[1];
   double myLastLowerBandValue=LowerBandArray[1]; 
       
      if (   // Check if we have a re-entry from below
            (PriceInfo[0].close>myLowerBandValue)
         && (PriceInfo[1].close<myLastLowerBandValue)
         )
            {
            entry="buy";
            } 
            
      if (   // Check if we have a re-entry from above
            (PriceInfo[0].close<myUpperBandValue)
         && (PriceInfo[1].close>myLastUpperBandValue)
         )
            {
            entry="sell";
            } 
            
      // sell 10 Mikrolot
      if (entry =="sell" && PositionsTotal()<1)
      trade.Sell(0.10,NULL,Bid,0,(Bid-50 * _Point),NULL);
	  
      if (entry =="buy" && PositionsTotal()<1)
      // buy 10 Mikrolot
      trade.Buy(0.10,NULL,Ask,0,(Ask+50 * _Point),NULL);  
      
         // Chart output of the current EA
   Comment ("Entry Signal: ",entry);   
  }
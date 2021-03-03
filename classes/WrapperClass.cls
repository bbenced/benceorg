public class WrapperClass{
        public Opportunity wrapOpportunity {get; set;}
        public List<Quote> wrapQuoteList {get; set;}
        
        public WrapperClass(Opportunity wrapOpportunity, List<Quote> wrapQuoteList){
            this.wrapOpportunity = wrapOpportunity;
            this.wrapQuoteList = wrapQuoteList;
        }
        
    }
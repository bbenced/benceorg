public class OnLoadController {

    public String Page {get; set;}
    public String OpenPageURL {get; set;}
    
    public void OnLoadController()
    {
        Page = '' ;
        OpenPageURL = '' ;
    }
    
    public PageReference redirect()
    {
        if(Page == 'google')
        {
            OpenPageURL = 'http://www.google.co.in/' ;
        }

        return null;
    }

}
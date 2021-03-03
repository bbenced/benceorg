({
    init: function(cmp) {
        cmp.set('v.myVal', '<p><script>alert(this)</script></p><p>hi!</p>');
    },

	 downloadDocument : function(component, event, helper){

  var sendDataProc = component.get("v.sendData");
  var dataToSend = {
     "label" : "This is test"
  }; //this is data you want to send for PDF generation

  //invoke vf page js method
  sendDataProc(dataToSend, function(){
              //handle callback
  });
 }


});
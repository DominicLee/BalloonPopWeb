function shareWin(total)
{

	var obj = {
          method: 'feed',
          link: 'http://dev.justine-40years.co.za/justine/balloon-pop/index.html',
          picture: 'http://dev.justine-40years.co.za/justine/balloon-pop/images/share.jpg',
          name: 'I just won with Justine',
          caption: 'Justine 40 Year Balloon Game',
          description: "I just played the Justine 40 Year Balloon Game and scored "+total+"."
        };

	FB.ui(obj, function(res){
		//console.log(res);
	});
	return false;

}

function shareWinner(name)
{

	var obj = {
       	  method: 'feed',
          link: 'http://www.radicaltech.co.za/clients/justine-balloon-web/index.html',
          picture: 'http://www.radicaltech.co.za/clients/justine-balloon-web/images/share.jpg',
          name: 'I just won with Justine',
          caption: 'Justine 40 Year Balloon Game',
          description: "I just won playing the Justine 40 Year Balloon Game"
    	};
          
	FB.ui(obj, function(res){
		//console.log(res);
	});
	return false;

}

function shareApp(total)
{

	var obj = {
          method: 'feed',
	  link: 'http://dev.justine-40years.co.za/justine/balloon-pop/index.html',
          picture: 'http://dev.justine-40years.co.za/justine/balloon-pop/images/share.jpg',        
          name: 'I just played the Justine 40 Year Balloon Game',
          caption: 'Justine 40 Year Balloon Game',
          description: "I just played the Justine 40 Year Balloon Game and scored "+total+"."
    	};

	FB.ui(obj, function(res){
		//console.log(res);
	});
	return false;

}

function showTerms()
{
	$('#terms').fadeIn(500);
}
function hideTerms()
{
	$('#terms').fadeOut(500);
}

<?
<<<CARSALES_USED_URL
Array (
    [0] => http://www.carsales.com.au/all-cars/results.aspx?silo=stock&q=((((SiloType=[Dealer used cars])
	    [1] => (SiloType=[Demo and near new cars]))
	    [2] => (SiloType=[Private seller cars]))&(Service=[Carsales]))&vertical=car&sortby=LastUpdated
)	}

carsales.mobi:
	div.r-content
		div.csn-results.csn-stock-results
			div.items.result
				ul.showroom
					li.ad-listing-gts (spotlight ad?)
					li	(no class on featured ads, only spotlight)
						a href=[car url] (and ID!)
							div
								span.price [price]
								h2 [car description: year,make,model,trans etc]
CARSALES_USED_URL;
$carsales = 'http://www.carsales.com.au/all-cars/results.aspx?silo=stock&q=%28%28%28%28SiloType%3d[Dealer+used+cars]%29|%28SiloType%3d[Demo+and+near+new+cars]%29%29|%28SiloType%3d[Private+seller+cars]%29%29%26%28Service%3d[Carsales]%29%29&vertical=car&sortby=LastUpdated';



$xml = simplexml_load_file($carsales);





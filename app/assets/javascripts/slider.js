$(window).ready(function(){
    var properties = $('#location > .col-sm-6')
    $("#ex2").slider()
    .on('change', function(event){
        var priceRange = event.value.newValue;
        properties.each(function(index, property){
            $property = $(property)
            price = $property.data('price')
            if (price >= priceRange[0] && price <= priceRange[1]){
                $property.show()
            } else {
                $property.hide()
            }
        })
    });
});


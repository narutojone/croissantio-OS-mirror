const links = [
  '<div class="img-container col-sm-12 col-md-2"><a target="_blank" href="https://www.hull.io" class="img-link">' + '<img class="company-img" alt="hull" src="' + window.location.origin + '/tools/' + 'hull.png' + '" />'+ '</a></div>',
  '<div class="img-container col-sm-12 col-md-2"><a target="_blank" href="https://clearbit.com" class="img-link">' + '<img class="company-img" alt="clearbit" src="' + window.location.origin + '/tools/' + 'clearbit.png' + '" />'+ '</a></div>',
  '<div class="img-container col-sm-12 col-md-2"><a target="_blank" href="https://zapier.com" class="img-link">' + '<img class="company-img" alt="zapier" src="' + window.location.origin + '/tools/' + 'zapier.png' + '" />'+ '</a></div>',
  '<div class="img-container col-sm-12 col-md-2"><a target="_blank" href="https://www.hotjar.com" class="img-link">' + '<img class="company-img" alt="hotjar" src="' + window.location.origin + '/tools/' + 'hotjar.png' + '" />'+ '</a></div>',
  '<div class="img-container col-sm-12 col-md-2"><a target="_blank" href="https://www.optimizely.com" class="img-link">' + '<img class="company-img opt" alt="opt" src="' + window.location.origin + '/tools/' + 'opt.png' + '" />'+ '</a></div>',
  '<div class="img-container col-sm-12 col-md-2"><a target="_blank" href="https://amplitude.com" class="img-link">' + '<img class="company-img" alt="amplitude" src="' + window.location.origin + '/tools/' + 'ampl.png' + '" />'+ '</a></div>',
  '<div class="img-container col-sm-12 col-md-2"><a target="_blank" href="https://www.madkudu.com" class="img-link">' + '<img class="company-img" alt="madkudu" src="' + window.location.origin + '/tools/' + 'madkudu.svg' + '" />'+ '</a></div>',
  '<div class="img-container col-sm-12 col-md-2"><a target="_blank" href="https://customer.io" class="img-link">' + '<img class="company-img" alt="customer" src="' + window.location.origin + '/tools/' + 'customer.png' + '" />'+ '</a></div>',
  '<div class="img-container col-sm-12 col-md-2"><a target="_blank" href="https://www.semrush.com" class="img-link">' + '<img class="company-img" alt="semrush" src="' + window.location.origin + '/tools/' + 'semrush.png' + '" />'+ '</a></div>',
  '<div class="img-container col-sm-12 col-md-2"><a target="_blank" href="https://segment.com/" class="img-link">' + '<img class="company-img" alt="segment" src="' + window.location.origin + '/tools/' + 'segment.png' + '" />'+ '</a></div>',
]

function shuffle(array) {
  var currentIndex = array.length, temporaryValue, randomIndex;

  // While there remain elements to shuffle...
  while (0 !== currentIndex) {

    // Pick a remaining element...
    randomIndex = Math.floor(Math.random() * currentIndex);
    currentIndex -= 1;

    // And swap it with the current element.
    temporaryValue = array[currentIndex];
    array[currentIndex] = array[randomIndex];
    array[randomIndex] = temporaryValue;
  }

  return array;
}

$(window).bind("load", function() {
  let newArray = shuffle(links)
  $.each( newArray, (index,value) => {
    if( index < 5 ) {
      $('.js--row-1').append(value)
    } else {
      $('.js--row-2').append(value)
    }
  })
  var delay = 0;
  $('.img-link').each(function(){ 
      $(this).delay(delay).animate({
          opacity: 0.9
      },500);
      delay += 500;
  });
})
;

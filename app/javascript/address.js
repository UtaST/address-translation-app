$(function() {
  return $('#postal_code').jpostal({
    postcode: ['#postal_code'],
    address: {
      '#prefecture' : '%3',
      '#city' : '%4',
      '#house_number' : '%5%6%7'
    },
  });
});
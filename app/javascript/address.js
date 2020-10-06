$(function() {
  return $('#postal_code').jpostal({
    postcode: ['#postal_code'],
    address: {
      '#prefecture' : '%3',
      '#city' : '%4',
      '#town_name' : '%5',
      '#house_number' : '%6%7'
    },
  });
});
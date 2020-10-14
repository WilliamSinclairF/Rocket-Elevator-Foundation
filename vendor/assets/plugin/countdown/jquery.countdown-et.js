/* http://keith-wood.name/countdown.html
   Estonian initialisation for the jQuery countdown extension
   Written by Helmer <helmer{at}city.ee> */
(function($) {
    $.countdown.regionalOptions['et'] = {
        labels: ['Aastat', 'Kuud', 'Ndalat', 'Peva', 'Tundi', 'Minutit', 'Sekundit'],
        labels1: ['Aasta', 'Kuu', 'Ndal', 'Pev', 'Tund', 'Minut', 'Sekund'],
        compactLabels: ['a', 'k', 'n', 'p'],
        whichLabels: null,
		digits: ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'],
        timeSeparator: ':', isRTL: false};
    $.countdown.setDefaults($.countdown.regionalOptions['et']);
})(jQuery);

$(window).ready(function(){
      var nowTemp = new Date();
      var now = new Date(nowTemp.getFullYear(), nowTemp.getMonth(), nowTemp.getDate(), 0, 0, 0, 0);
      var checkin = $('#checkin').datepicker({
        onRender: function(date) {
          return date.valueOf() < now.valueOf() ? 'disabled' : '';
        }
      }).on('changeDate', function(ev) {
        if (ev.date.valueOf() > checkout.date.valueOf()) {
          var newDate = new Date(ev.date)
          newDate.setDate(newDate.getDate() + 1);
          checkout.setValue(newDate);
        }
        checkin.hide();
        $('#checkout')[0].focus();
      }).data('datepicker');
      var checkout = $('#checkout').datepicker({
        onRender: function(date) {
          return date.valueOf() <= checkin.date.valueOf() ? 'disabled' : '';
        }
      }).on('changeDate', function(ev) {
        checkout.hide();
      }).data('datepicker');
    });
1
2
3
4
5
6
7
8
9
10
11
12
13
14
15
16
17
18
19
20
21
22
23
24
$(window).ready(function(){
      var nowTemp = new Date();
      var now = new Date(nowTemp.getFullYear(), nowTemp.getMonth(), nowTemp.getDate(), 0, 0, 0, 0);
      var checkin = $('#checkin').datepicker({
        onRender: function(date) {
          return date.valueOf() < now.valueOf() ? 'disabled' : '';
        }
      }).on('changeDate', function(ev) {
        if (ev.date.valueOf() > checkout.date.valueOf()) {
          var newDate = new Date(ev.date)
          newDate.setDate(newDate.getDate() + 1);
          checkout.setValue(newDate);
        }
        checkin.hide();
        $('#checkout')[0].focus();
      }).data('datepicker');
      var checkout = $('#checkout').datepicker({
        onRender: function(date) {
          return date.valueOf() <= checkin.date.valueOf() ? 'disabled' : '';
        }
      }).on('changeDate', function(ev) {
        checkout.hide();
      }).data('datepicker');
    });

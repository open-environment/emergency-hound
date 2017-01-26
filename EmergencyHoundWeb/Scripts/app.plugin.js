!function ($) {

  $(function(){
 	
	//// sparkline
	//var sr, sparkline = function($re){
	//	$(".sparkline").each(function(){
	//		var $data = $(this).data();
	//		if($re && !$data.resize) return;
	//		($data.type == 'pie') && $data.sliceColors && ($data.sliceColors = eval($data.sliceColors));
	//		($data.type == 'bar') && $data.stackedBarColor && ($data.stackedBarColor = eval($data.stackedBarColor));
	//		$data.valueSpots = {'0:': $data.spotColor};
	//		$(this).sparkline('html', $data);
	//	});
	//};
	//$(window).resize(function(e) {
	//	clearTimeout(sr);
	//	sr = setTimeout(function(){sparkline(true)}, 500);
	//});
	//sparkline(false);


  	// combodate
	$(".combodate").each(function(){ 
		$(this).combodate();
		$(this).next('.combodate').find('select').addClass('form-control');
	});

    // datetime-picker formatting
	jQuery('.datetime-picker').datetimepicker({
	    format: 'm/d/Y h:i:s A'
	});


	// datepicker
    //	$(".datepicker-input").each(function(){ $(this).datepicker();});

	// dropfile
	$('.dropfile').each(function(){
		var $dropbox = $(this);
		if (typeof window.FileReader === 'undefined') {
		  $('small',this).html('File API & FileReader API not supported').addClass('text-danger');
		  return;
		}

		this.ondragover = function () {$dropbox.addClass('hover'); return false; };
		this.ondragend = function () {$dropbox.removeClass('hover'); return false; };
		this.ondrop = function (e) {
		  e.preventDefault();
		  $dropbox.removeClass('hover').html('');
		  var file = e.dataTransfer.files[0],
		      reader = new FileReader();
		  reader.onload = function (event) {
		  	$dropbox.append($('<img>').attr('src', event.target.result));
		  };
		  reader.readAsDataURL(file);
		  return false;
		};
	});

	//// fuelux pillbox
	//var addPill = function($input){
	//	var $text = $input.val(), $pills = $input.closest('.pillbox'), $repeat = false, $repeatPill;
	//	if($text == "") return;
	//	$("li", $pills).text(function(i,v){
	//        if(v == $text){
	//        	$repeatPill = $(this);
	//        	$repeat = true;
	//        }
	//    });
	//    if($repeat) {
	//    	$repeatPill.fadeOut().fadeIn();
	//    	return;
	//    };
	//    $item = $('<li class="label bg-dark">'+$text+'</li> ');
	//	$item.insertBefore($input);
	//	$input.val('');
	//	$pills.trigger('change', $item);
	//};

	//$('.pillbox input').on('blur', function() {
	//	addPill($(this));
	//});

	//$('.pillbox input').on('keypress', function(e) {
	//    if(e.which == 13) {
	//        e.preventDefault();
	//        addPill($(this));
	//    }
	//});

	// slider
	$('.slider').each(function(){
		$(this).slider();
	});

	// sortable
	if ($.fn.sortable) {
	  $('.sortable').sortable();
	}

	// pjax
	if ($.support.pjax) {
	  $(document).on('click', 'a[data-pjax]', function(event) {
	  	event.preventDefault();
	    var container = $($(this).data('target'));
	    $.pjax.click(event, {container: container});
	  })
	};

	// portlet
	$('.portlet').each(function(){
		$(".portlet").sortable({
	        connectWith: '.portlet',
            iframeFix: false,
            items: '.portlet-item',
            opacity: 0.8,
            helper: 'original',
            revert: true,
            forceHelperSize: true,
            placeholder: 'sortable-box-placeholder round-all',
            forcePlaceholderSize: true,
            tolerance: 'pointer'
	    });
    });

	// docs
    $('#docs pre code').each(function(){
	    var $this = $(this);
	    var t = $this.html();
	    $this.html(t.replace(/</g, '&lt;').replace(/>/g, '&gt;'));
	});

	// table select/deselect all
	$(document).on('change', 'table thead [type="checkbox"]', function(e){
		e && e.preventDefault();
		var $table = $(e.target).closest('table'), $checked = $(e.target).is(':checked');
		$('tbody [type="checkbox"]',$table).prop('checked', $checked);
	});

	// random progress
	//$(document).on('click', '[data-toggle^="progress"]', function(e){
	//	e && e.preventDefault();

	//	$el = $(e.target);
	//	$target = $($el.data('target'));
	//	$('.progress', $target).each(
	//		function(){
	//			var $max = 50, $data, $ps = $('.progress-bar',this).last();
	//			($(this).hasClass('progress-xs') || $(this).hasClass('progress-sm')) && ($max = 100);
	//			$data = Math.floor(Math.random()*$max)+'%';
	//			$ps.css('width', $data).attr('data-original-title', $data);
	//		}
	//	);
	//});
	

	// select2 
 	if ($.fn.select2) {
      $("#select2-option").select2();
      $("#select2-tags").select2({
        tags:["red", "green", "blue"],
        tokenSeparators: [",", " "]}
      );
  	}


  });
}(window.jQuery);
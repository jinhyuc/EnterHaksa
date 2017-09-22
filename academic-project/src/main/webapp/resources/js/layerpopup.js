/**
 * Layer popup (confirm, alert) JavaScript
 */

var layer_popup = {
		confirm : function(el, msg, callback_confirm) {
			var $el = el;
			
			el.find('.div-popmsg .message').html(msg);
			
			$('.confirm-layer').fadeIn();
			
			var $elWidth = $el.outerWidth();
			var	$elHeight = $el.outerHeight();
			var	docWidth = $(document).width();
			var	docHeight = $(document).height();
				
			if($elHeight < docHeight || $elWidth < docWidth) {
				$el.css({
					marginTop: -$elHeight / 2,
					marginLeft: -$elWidth / 2
				});
			} else {
				$el.css({top: 0, left: 0});
			}
			
			$('.div-popbtn .ok').on("click", function(event) {
				event.preventDefault();
				
				$('.confirm-layer').fadeOut();
				
				if(callback_confirm) {
					callback_confirm();
				}
			});
			
			$('.div-popbtn .cancel').on("click", function(event) {
				event.preventDefault();
				
				$('.confirm-layer').fadeOut();
			});
			
			$('.confirm-layer .layer-bg').click(function(event) {
				event.preventDefault();
				
				$('.confirm-layer').fadeOut();
			});
		},
		
		alert : function(el, msg, callback_alert) {
			var $el = el;
			
			$el.find('.div-popmsg .message').html(msg)
			
			$('.alert-layer').fadeIn();
			
			var $elWidth = $el.outerWidth();
			var	$elHeight = $el.outerHeight();
			var	docWidth = $(document).width();
			var	docHeight = $(document).height();
				
			if($elHeight < docHeight || $elWidth < docWidth) {
				$el.css({
					marginTop: -$elHeight / 2,
					marginLeft: -$elWidth / 2
				});
			} else {
				$el.css({top: 0, left: 0});
			}
			
			$el.find('.div-popbtn .ok').on("click", function(event) {
				event.preventDefault();
				
				$('.alert-layer').fadeOut();
				
				if(callback_alert) {
					callback_alert();
				}
			});
			
			$('.alert-layer .layer-bg').click(function(event) {
				event.preventDefault();
				
				$('.alert-layer').fadeOut();
				
				if(callback_alert) {
					callback_alert();
				}
				
			});
		}
}
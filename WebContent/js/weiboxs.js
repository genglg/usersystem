var weiBoxs = new Object();

Wind.use('bootbox', function () {
    weiBoxs.alert = function (content, callback) {
        bootbox.dialog({
            message: content,
            title: "提示信息",
            className: "modal-darkorange",
            buttons: {
                "确定": {
                    className: "btn-danger",
                    callback: function () {
                        if (typeof callback == 'function') {
                            callback();
                        }
                    }
                }
            }
        });
    }

    weiBoxs.confirm = function (content, callback) {
        bootbox.confirm({
            message: content,
            className: "modal-primary",
            title: "提示信息",
            buttons: {
                cancel: {
                    label: '取消',
                    className: 'btn-default'
                },
                confirm: {
                    label: '确认',
                    className: "btn-danger"
                }
            },
            callback: function (result) {
                if (result) {
                    if (typeof callback == 'function') {
                        callback();
                    }
                }
            }
        });
    }
    weiBoxs.toasst = function (content, types) {

        Wind.use('toastrs', function(){
            Wind.css('toastrs', function(){
                toastr.options = {
                    "closeButton": true,
                    "debug": false,
                    "progressBar": true,
                    "positionClass": "toast-bottom-right",
                    "onclick": null,
                    "showDuration": "400",
                    "hideDuration": "1000",
                    "timeOut": "7000",
                    "extendedTimeOut": "1000",
                    "showEasing": "swing",
                    "hideEasing": "linear",
                    "showMethod": "fadeIn",
                    "hideMethod": "fadeOut"
                };
                if(types == 'success') {
                    toastr.success(content);
                }else if(types == 'error') {
                    toastr.error(content);
                }else if(types == 'warning') {
                    toastr.warning(content);
                } else {
                    toastr.info(content);
                }
            });
        });
    }
});

$('.btn-delete-dialog').click(function () {
    var thisObj = $(this);
    var Tips = thisObj.attr('dialog-tip');
    if (!Tips) {
        Tips = '确定要删除吗？';
    }
    var url = thisObj.attr('href');
    weiBoxs.confirm(Tips, function () {
        location = url;
    });
    return false;
});
var modalDialog;

weiBoxs.dialog = function (obj) {
    var thisObj = $(obj);
    var title = thisObj.attr('dialog-title') ? thisObj.attr('dialog-title') : '弹窗';
    var pageurl = thisObj.attr('dialog-url') ? thisObj.attr('dialog-url') : thisObj.attr('href');
    var sizeOptions = thisObj.attr('dialog-size');
    var button = thisObj.attr('dialog-button');
    var callback = thisObj.attr('dialog-callback');

    size = 'large';
    if (sizeOptions) {
        size = sizeOptions;
    }
    if(pageurl == undefined) {
        return false;
    }
    var htmlobj = $.ajax({url: pageurl, async: false});
    message = htmlobj.responseText;
    if (htmlobj.status != 200) {
        weiBoxs.alert(message, function () {
        });
        return false;
    }
    var buttonValue = [{
        label: '取消',
        className: "btn-blue",
        callback: function () {
        }
    }, {
        label: '确定',
        className: "btn-danger",
        callback: function () {
            if (callback != undefined) {
                var func = eval(callback);
                return func();
            } else {
                return actionCallBack();
            }
        }
    }]
    if (button == "false") {
        buttonValue = [];
    }
    Wind.use('bootbox', function () {
        modalDialog = bootbox.dialog({
            message: message,
            title: title,
            size: size,
            className: "modal-darkorange",
            buttons: buttonValue
        });
    });
}

$('.weiBoxs-dialog').click(function () {
    weiBoxs.dialog($(this));
    return false;
});

function changeCondition() {
    var a = $("#field option:selected").attr('class');
    var b = $("#field option:selected").val();
    var c = $("#field option:selected").attr('rel');
	$("#searchContent,#conditionContent").hide();
    $("#conditionContent").html('');
    if (a == 'text' || a == 'textarea' || a == 'editor' || a == 'mobile' || a == 'phone' || a == 'email' || a == 'address') {
        $("#conditionContent").html('<select id="condition" class="form-control input-xs" name="condition">'
        + '<option value="eq">  等于  </option>'
        + '<option value="like">  模糊  </option>'
        + '</select>').show();
        $("#searchContent").html('<input id="keyword" type="text" class="form-control input-xs" name="keyword"/>').show();

    } else if (a == 'number' || a == 'floatnumber') {
        $("#conditionContent").html('<select id="condition" class="form-control input-xs" name="condition">'
        + '<option value="gt">  大于  </option>'
        + '<option value="lt">  小于  </option>'
        + '<option value="eq">  等于  </option>'
        + '<option value="neq">  不等于  </option>'
        + '</select>').show();
        $("#searchContent").html('<input id="keyword" type="text" class="form-control input-xs" name="keyword"/>').show();
    } else if (a == 'owner') {
        var u = $("#field option:selected").attr('url');
        $.ajax({
            type: 'get',
            url: u,
            async: false,
            success: function (data) {
                options = '';
                $.each(data.data.list, function (k, v) {
                    options += '<option value="' + v.id + '">' + v.name + ' [' + v.department + '-' + v.position + ']</option>';
                });
                $("#searchContent").html('<select id="keyword" class="form-control input-xs" name="keyword">' + options + '</select>').show();
                $('#conditionContent').hide();
            },
            dataType: 'json'
        });
    } else if (a == 'date' || a == 'datetime') {
        Wind.use('datetimepicker', function () {
            Wind.css('datetimepicker', function () {
                $("#searchContent").html('<input id="keyword1" class="form-control form_datetime input-xs" style="width:120px;" type="text" name="keyword[]" readonly="readonly"/>&nbsp;－&nbsp;<input id="keyword2" class="form-control form_datetime input-xs" type="text" style="width:120px;" name="keyword[]" readonly="readonly"/>').show();
                $('.form_datetime').datetimepicker({
                    lang: 'ch',
                    timepicker: false,
                    format: 'Y-m-d'
                });
            });
        });
    } else if (a == 'box') {
        var u = $("#field option:selected").attr('url');
        $.ajax({
            type: 'get',
            url: u,
            data: 'model_id=' + c + '&field=' + b,
            async: false,
            success: function (data) {
                options = '';
                $.each(data, function (k, v) {
                    options += '<option value="' + k + '">' + v + '</option>';
                });
                $("#searchContent").html('<select id="keyword" class="form-control input-xs" name="keyword">' + options + '</select>').show();
            },
            dataType: 'json'
        });
    }

}

jQuery.fn.onlypressnum = function () {
    $(this).css({imeMode: "disabled", '-moz-user-select': "none"});
    $(this).bind("keypress", function (e) {
        if (e.ctrlKey == true || e.shiftKey == true)
            return false;
        if ((e.which >= 48 && e.which <= 57 && e.ctrlKey == false && e.shiftKey == false) || e.which == 0 || e.which == 8 || e.which == 13 || e.which == 46)
            return true;
        else if (e.ctrlKey == true && (e.which == 99 || e.which == 118))
            return false;
        else
            return false;
    })
        .bind("contextmenu", function () {
            return false;
        })
        .bind("drop", function () {
            return false;
        })
        .bind("paste", function () {
            if (isNaN(parseFloat(window.clipboardData.getData("text")))) {
                return false;
            }
        });
};


/*!
 * jQuery Cookie Plugin v1.3.1
 * https://github.com/carhartl/jquery-cookie
 *
 * Copyright 2013 Klaus Hartl
 * Released under the MIT license
 */

(function(e){if(typeof define==="function"&&define.amd){define(["jquery"],e)}else{e(jQuery)}})(function(e){function n(e){if(i.raw){return e}return decodeURIComponent(e.replace(t," "))}function r(e){if(e.indexOf('"')===0){e=e.slice(1,-1).replace(/\\"/g,'"').replace(/\\\\/g,"\\")}e=n(e);try{return i.json?JSON.parse(e):e}catch(t){}}var t=/\+/g;var i=e.cookie=function(t,s,o){if(s!==undefined){o=e.extend({},i.defaults,o);if(typeof o.expires==="number"){var u=o.expires,a=o.expires=new Date;a.setDate(a.getDate()+u)}s=i.json?JSON.stringify(s):String(s);return document.cookie=[i.raw?t:encodeURIComponent(t),"=",i.raw?s:encodeURIComponent(s),o.expires?"; expires="+o.expires.toUTCString():"",o.path?"; path="+o.path:"",o.domain?"; domain="+o.domain:"",o.secure?"; secure":""].join("")}var f=document.cookie.split("; ");var l=t?undefined:{};for(var c=0,h=f.length;c<h;c++){var p=f[c].split("=");var d=n(p.shift());var v=p.join("=");if(t&&t===d){l=r(v);break}if(!t){l[d]=r(v)}}return l};i.defaults={};e.removeCookie=function(t,n){if(e.cookie(t)!==undefined){e.cookie(t,"",e.extend({},n,{expires:-1}));return true}return false}})

$(document).ready(function() {
    /*
    # =============================================================================
    #   Navbar scroll animation
    # =============================================================================
    */
    $(".navbar.scroll-hide").mouseover(function() {
      $(".navbar.scroll-hide").removeClass("closed");
      return setTimeout((function() {
        return $(".navbar.scroll-hide").css({
          overflow: "visible"
        });
      }), 150);
    });
    $(function() {
      var delta, lastScrollTop;
      lastScrollTop = 0;
      delta = 50;
      return $(window).scroll(function(event) {
        var st;
        st = $(this).scrollTop();
        if (Math.abs(lastScrollTop - st) <= delta) {
          return;
        }
        if (st > lastScrollTop) {
          $('.navbar.scroll-hide').addClass("closed");
        } else {
          $('.navbar.scroll-hide').removeClass("closed");
        }
        return lastScrollTop = st;
      });
    });
    /*
    # =============================================================================
    #   Mobile Nav
    # =============================================================================
    */

    $('.navbar-toggle').click(function() {
      return $('body, html').toggleClass("nav-open");
    });
    /*
    # =============================================================================
    #   jQuery UI Sliders
    # =============================================================================
    */

    $(".slider-basic").slider({
      range: "min",
      value: 50,
      slide: function(event, ui) {
        return $(".slider-basic-amount").html("$" + ui.value);
      }
    });
    $(".slider-basic-amount").html("$" + $(".slider-basic").slider("value"));
    $(".slider-increments").slider({
      range: "min",
      value: 30,
      step: 10,
      slide: function(event, ui) {
        return $(".slider-increments-amount").html("$" + ui.value);
      }
    });
    $(".slider-increments-amount").html("$" + $(".slider-increments").slider("value"));
    $(".slider-range").slider({
      range: true,
      values: [15, 70],
      slide: function(event, ui) {
        return $(".slider-range-amount").html("$" + ui.values[0] + " - $" + ui.values[1]);
      }
    });
    $(".slider-range-amount").html("$" + $(".slider-range").slider("values", 0) + " - $" + $(".slider-range").slider("values", 1));
    /*
    # =============================================================================
    #   Bootstrap Tabs
    # =============================================================================
    */

    $("#myTab a:last").tab("show");
    /*
    # =============================================================================
    #   Bootstrap Popover
    # =============================================================================
    */

    $("#popover").popover();
    $("#popover-left").popover({
      placement: "left"
    });
    $("#popover-top").popover({
      placement: "top"
    });
    $("#popover-right").popover({
      placement: "right"
    });
    $("#popover-bottom").popover({
      placement: "bottom"
    });
    /*
    # =============================================================================
    #   Bootstrap Tooltip
    # =============================================================================
    */
    $("#tooltip").tooltip();
    $("#tooltip-left").tooltip({
      placement: "left"
    });
    $("#tooltip-top").tooltip({
      placement: "top"
    });
    $("#tooltip-right").tooltip({
      placement: "right"
    });
    $("#tooltip-bottom").tooltip({
      placement: "bottom"
    });
    /*
    # =============================================================================
    #   Isotope
    # =============================================================================
    */
	
    $container = $(".gallery-container");
	$container.isotope({});
		$(".gallery-filters a").click(function() {
		  var selector;
		  selector = $(this).attr("data-filter");
		  $(".gallery-filters a.selected").removeClass("selected");
		  $(this).addClass("selected");
		  $container.isotope({
			filter: selector
		  });
		  return false;
	});
	
    /*
    # =============================================================================
    #   Select2
    # =============================================================================
    */

    /*$('.select2able').select2();*/
    /*
    # =============================================================================
    #   Isotope with Masonry
    # =============================================================================
    */

    $alpha = $('#hidden-items');
    $container2 = $('#social-container');
    $(window).load(function() {
      /*
      # init isotope, then insert all items from hidden alpha
      */

      $container2.isotope({
        itemSelector: '.item'
      }).isotope('insert', $alpha.find('.item'));
      return $("#load-more").html("Load more").find("i").hide();
    });
    $('#load-more').click(function() {
      var item1, item2, item3, items, tmp;
      items = $container2.find('.social-entry');
      item1 = $(items[Math.floor(Math.random() * items.length)]).clone();
      item2 = $(items[Math.floor(Math.random() * items.length)]).clone();
      item3 = $(items[Math.floor(Math.random() * items.length)]).clone();
      tmp = $().add(item1).add(item2).add(item3);
      return $container2.isotope('insert', tmp);
    });
    
   
    /*
    # =============================================================================
    #   Drag and drop files
    # =============================================================================
    */

    $(".single-file-drop").each(function() {
      var $dropbox;
      $dropbox = $(this);
      if (typeof window.FileReader === "undefined") {
        $("small", this).html("File API & FileReader API not supported").addClass("text-danger");
        return;
      }
      this.ondragover = function() {
        $dropbox.addClass("hover");
        return false;
      };
      this.ondragend = function() {
        $dropbox.removeClass("hover");
        return false;
      };
      return this.ondrop = function(e) {
        var file, reader;
        e.preventDefault();
        $dropbox.removeClass("hover").html("");
        file = e.dataTransfer.files[0];
        reader = new FileReader();
        reader.onload = function(event) {
          return $dropbox.append($("<img>").attr("src", event.target.result));
        };
        reader.readAsDataURL(file);
        return false;
      };
    });

    /*
    # =============================================================================
    #   Input placeholder fix
    # =============================================================================
    */

    if (!Modernizr.input.placeholder) {
      $("[placeholder]").focus(function() {
        var input;
        input = $(this);
        if (input.val() === input.attr("placeholder")) {
          input.val("");
          return input.removeClass("placeholder");
        }
      }).blur(function() {
        var input;
        input = $(this);
        if (input.val() === "" || input.val() === input.attr("placeholder")) {
          input.addClass("placeholder");
          return input.val(input.attr("placeholder"));
        }
      }).blur();
      return $("[placeholder]").parents("form").submit(function() {
        return $(this).find("[placeholder]").each(function() {
          var input;
          input = $(this);
          if (input.val() === input.attr("placeholder")) {
            return input.val("");
          }
        });
      });
    }
});

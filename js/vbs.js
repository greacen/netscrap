// Dependencies:
// JS: jquery-1.3.2,min.js, browser-detect.js, swfobject.js
// Files: /downloads/vbstest
// HTM: /chromepopuptest.htm
// Images: /images/vsblog.gif
// Cookie: 'UserID=<whatever>'

$(document).ready(function() {
  VBS.init()
});

if (typeof VBS == 'undefined') {
  VBS = {};
};

VBS = {
  version: '1',
  debug: false,
  debug_params: null,
  log_values: [],
  start_time: null,
  elapsed_time: null,
  completed_cookie_name: 'vbstestcompleted',
  tests: [],

  init: function() {
    VBS.tests = [
                  VBS.Checks.cookies, 
                  VBS.Checks.browser_version, 
                  VBS.Checks.resolution,
                  VBS.Checks.flash,
                  VBS.Checks.popup,
                  VBS.Checks.files
                ]
    if (VBS.debug) {
      VBS.enable_debug();
    }
    VBS.check();
  },

  Resources: {
    Urls: {
      public_path: '/media/vbs/',
      chromepopuptest: '/media/vbs/chromepopuptest.htm',
      tracking_image_path: '/media/vbs/vsblog.gif'
    }
  },

  Utils: {
    set_cookie: function(name, value, days) {
      var exp_date = new Date();
      if (days) {
        exp_date.setDate(exp_date.getDate() + days);
      }
      var c_value = escape(value) + ((days==null) ? "" : "; expires="+exp_date.toUTCString());
      document.cookie = name + "=" + c_value;
    },

    get_cookie: function(c_name) {
      var i,x,y,ARRcookies=document.cookie.split(";");
      for (i=0;i<ARRcookies.length;i++) {
        x=ARRcookies[i].substr(0,ARRcookies[i].indexOf("="));
        y=ARRcookies[i].substr(ARRcookies[i].indexOf("=")+1);
        x=x.replace(/^\s+|\s+$/g,"");
        if (x==c_name) {
          return unescape(y);
        }
      }
    },

    clear_cookie: function(c_name) {
      document.cookie = encodeURIComponent(c_name) + "=deleted; expires=" + new Date(0).toUTCString();
    }
  },

  tracking_string: function() {
    var result = "?vbsv=" + VBS.version + '&fto=' + VBS.Checks.files.timeout + '&';
    var vbs_uid_c_name = 'UserID';
    var vbs_uid = VBS.Utils.get_cookie(vbs_uid_c_name);
    var uid = vbs_uid ? vbs_uid : 'xxxxx';
    result += ("vbsuid=" + uid + '&');
    if (VBS.log_values.length > 0) {
      var loopend = VBS.log_values.length;
      for (var i=0; i < loopend; i++) {
        result += (VBS.log_values[i] + (i == loopend - 1  ? '' : "&"));
      }
    }
    return result;
  },

  log_results: function() {
    var tracking_image = new Image();
    tracking_image.src = VBS.Resources.Urls.tracking_image_path + VBS.tracking_string();
    VBS.debug_log('output path: ' + tracking_image.src);
  },

  enable_debug: function(params) {
    VBS.debug = true;
    if (params) {
      VBS.debug_params = params;
    }
    var debug_console_style = "position: absolute; width: 1400px; height: 600px; z-index: 99; background-color: #fff; color: #000; font-size: 12px; top: 100px; left: 10px; padding: 5px; border: 2px solid black;";
    var debug_console = '<div id="vbs_debug_console" style="' + 
                        debug_console_style + 
                        '"><div style="height: 20px;">' +
                        '<a href="javascript:VBS.clear_console();">Clear</a>' + 
                        '</div><div style="height: 500px; border: 1px solid red; padding: 0 23px 23px 0; overflow: auto;" id="vbs_debug_console_text"></div></div>';
    $('body').append(debug_console);
  },

  debug_log: function(msg) {
    var debug_msg = '<div style="margin-bottom: 5px;">' + msg + '</div>';
    $('#vbs_debug_console_text').append(debug_msg);
  },

  clear_console: function() {
    $('#vbs_debug_console_text').html('');
  },

  force_check: function() {
    // clear cookie and VBS data
    VBS.Utils.clear_cookie(VBS.completed_cookie_name);
    VBS.clear_data();
    VBS.check();
  },

  clear_data: function() {
    var tests = VBS.tests;
    for (var i=0; i<tests.length;i++) {
      tests[i]['result'] = null;
      tests[i]['completed'] = false;
    }
    VBS.Checks.files.index = 0;
    VBS.Checks.files.current_file = 0;
    var file_tests = VBS.Checks.files.file_list;
    for (var x=0; x<file_tests.length;x++) {
      file_tests[x]['result'] = null;
    }
    VBS.Checks.popup.chrome_test_count = 0;
    VBS.log_values = [];
  },

  check: function() {
    VBS.debug_log("##################################");
    if (VBS.Utils.get_cookie(VBS.completed_cookie_name) !== 'true') {
      VBS.start_time = new Date().getTime();
      VBS.Utils.set_cookie(VBS.completed_cookie_name, 'true'); 
      VBS.run_check(VBS.Checks.cookies);
      VBS.run_check(VBS.Checks.browser_version);  
      VBS.run_check(VBS.Checks.resolution);
      VBS.run_check(VBS.Checks.flash);
      VBS.run_check(VBS.Checks.popup);
      VBS.run_check(VBS.Checks.files);

    } else {
      VBS.debug_log('test suite already ran in this session.');
    }
  },

  run_check: function(check_obj) {
    if (check_obj.disabled) {
      return true;
    }
    check_obj.check();

    (function poll_results(){
      setTimeout(function(){                       
        if (check_obj.result === null || check_obj.result === 'testing') {
          poll_results();
        } else {
          VBS.debug_log('results are in for ' + check_obj['name'] + ', calling tracking with result value of ' + check_obj['result'] );
          check_obj.tracking();
          check_obj.completed = true;
          if (VBS.Checks.checks_complete()) {
            VBS.elapsed_time = (new Date().getTime() - VBS.start_time);
            VBS.log_values.push('elapsed_time=' + VBS.elapsed_time.toString());
            VBS.debug_log('elapsed time : ' + VBS.elapsed_time);
            VBS.log_results();
          }
        }
      }, 5);
    })(); 
  },

  Checks: {
    checks_complete: function() {
      var complete = true;
      var tests =VBS.tests;
      for (var i=0;i<tests.length;i++) {
        if (!tests[i].disabled && tests[i]['completed'] !== true) {
          complete = false;
        }
      }
      return complete;
    },

    cookies: {
      name: 'cookies',
      completed: false, 
      result: null,
      disabled: true,
      check: function() {
        var msg = this.cookies_enabled() === true ? 'p' : 'f';
        this.result = msg;
        VBS.debug_log('check cookies result: ' + msg);
      },

      tracking: function() {
        VBS.log_values.push('cookies=' + this.result);
      },

      cookies_enabled: function() {
        var cookieEnabled = (navigator.cookieEnabled) ? true : false;
        if (typeof navigator.cookieEnabled == "undefined" && !cookieEnabled) { 
          var cookie_name = 'testcookie';
          VBS.Utils.set_cookie(cookie_name, 'true');
          if (VBS.Utils.get_cookie(cookie_name) === 'true') {
            cookieEnabled = true;
            VBS.Utils.clear_cookie(cookie_name);
          }
        }
        return (cookieEnabled);
      }
    },

    browser_version: {
      name: 'browser_version',
      completed: false,
      result: null,
      disabled: false,
      bname: null,
      bversion: null,

      check: function() {
        if (typeof BrowserDetect !== "undefined"){
          this.bname = BrowserDetect.browser;
          this.bversion = BrowserDetect.version;
          if (this.bname === "Explorer") {
            if (this.bversion >= 6) {
              this.result = 'p';
            } else {
              this.result = 'f';
            }
          } else {
            // all non-IE browsers pass this test
            this.result = 'p';
          }
        } else {
          VBS.debug_log('*********************** browser detect library failed to load')
          this.result = 'f';
          this.bname  = 'u';
          this.bversion = 'u';
        }

        VBS.debug_log('check browser version result: ' + this.result);
      },

      tracking: function() {
        VBS.log_values.push('bn=' + this.bname);
        VBS.log_values.push('bv=' + this.bversion);
        VBS.log_values.push('btest=' + this.result);
      }
    },

    files: {
      name: 'files',
      completed: false,
      result: null,
      disabled: false,
      index: 0,
      loopend: 0,
      current_file: null,
      timeout: 300,
      file_name: 'vbstest',
      file_list: [
                    {'fname' : 'mp3', 'ftext' : 'mp3file', 'result' : null},
                    {'fname' : 'mp4', 'ftext' : 'mp4file', 'result' : null},
                    {'fname' : 'm4v', 'ftext' : 'm4vfile', 'result' : null},
                    {'fname' : 'flv', 'ftext' : 'flvfile', 'result' : null},
                    {'fname' : 'f4v', 'ftext' : 'f4vfile', 'result' : null},
                    {'fname' : 'swc', 'ftext' : 'swcfile', 'result' : null},
                    {'fname' : 'swf', 'ftext' : 'swffile', 'result' : null},
                    {'fname' : 'swz', 'ftext' : 'swzfile', 'result' : null},
                    {'fname' : 'xml', 'ftext' : 'xmlfile', 'result' : null},
                    {'fname' : 'png', 'ftext' : 'pngfile', 'result' : null},
                    {'fname' : 'mov', 'ftext' : 'movfile', 'result' : null}
                  ],

      check: function() {
        var that = this;
        that.result = "testing";
        that.loopend = that.file_list.length;
        VBS.Checks.files.current_file = VBS.Checks.files.file_list[VBS.Checks.files.index];
        (function poll(){
          setTimeout(function(){                       
            if (VBS.Checks.files.index < VBS.Checks.files.loopend) {
              //VBS.debug_log('passed the index condition');
              //VBS.debug_log('inside poll: index is ' + VBS.Checks.files.index + ', current file name is ' + VBS.Checks.files.current_file['fname'] + ' and about to see if result is null: ' + VBS.Checks.files.current_file['result']);
              if (VBS.Checks.files.current_file['result'] === null) {
                //VBS.debug_log('result is not testing and the test is not underway, so fetching file');
                VBS.Checks.files.fetch_file();
              }
              poll();
            } else {
              VBS.Checks.files.result = !VBS.Checks.files.has_test_failures() ? 'p' : 'f';
              VBS.debug_log('all file tests completed: ' + VBS.Checks.files.result);
            }
          }, 5);
        })();
      },

      has_test_failures: function() {
        has_failures = false;
        for(var i=0;i<VBS.Checks.files.loopend;i++) {
          if (VBS.Checks.files.file_list[i]['result'] !== 'p') {
            has_failures = true
          }
        }
        return has_failures;
      },

      fetch_file: function() {
        $.ajax({
          timeout: VBS.Checks.files.timeout,
          dataType: 'text',
          contentType: 'text/plain',
          accepts: {text: 'text/plain'},
          url: VBS.Resources.Urls.public_path + VBS.Checks.files.file_name + '.' + VBS.Checks.files.current_file['fname'],

          beforeSend: function(jqXHR, settings) {
            VBS.Checks.files.current_file['result'] = 'testing';
          },

          success: function(data, textStatus, jqXHR) {
            if (data.search(VBS.Checks.files.current_file['ftext']) > -1) {
              // VBS.debug_log('SUCCESS: file test succeeded, data: ' + data);
              VBS.Checks.files.current_file['result'] = 'p';
            } else {
              // VBS.debug_log('INVALID DATA: file test for ' + VBS.Checks.files.current_file['fname'] + ' with text: ' +  VBS.Checks.files.current_file['ftext'] + ' failed, data: ' + data);
              VBS.Checks.files.current_file['result'] = 'f';
            }
          },

          error: function(jqHXR, textStatus, errorThrown) {
            VBS.debug_log('ERROR: index is ' + VBS.Checks.files.index + ', filename is ' + VBS.Checks.files.current_file['fname'] + ', filetext is ' + VBS.Checks.files.current_file['ftext']);
            VBS.debug_log('file test error textStatus: ' + textStatus);
            var error_msg = "";
            if (textStatus.toLowerCase() === "timeout") {
              error_msg = "timeout";
            } else {
              error_msg = "f";
            }
            VBS.Checks.files.current_file['result'] = error_msg;
          },

          complete: function() {
            VBS.debug_log('AJAX complete: the current index number is ' + VBS.Checks.files.index)
            VBS.debug_log(' and the current result is ' + VBS.Checks.files.current_file['result']);
            VBS.log_values.push(VBS.Checks.files.current_file['fname'] + "=" + VBS.Checks.files.current_file['result']);

            VBS.Checks.files.index++;
            if (VBS.Checks.files.index < VBS.Checks.files.loopend) {
              VBS.Checks.files.current_file = VBS.Checks.files.file_list[VBS.Checks.files.index];
            }
          }
        });
      },
      tracking: function() {
        VBS.log_values.push('files=' + VBS.Checks.files.result);
      }
    },

    resolution: {
      name: 'resolution',
      completed: false,
      result: null,
      disabled: false,

      check: function() {
        if (screen.width >= 800 && screen.height >= 600) {
          this.result = 'p';
        } else {
          this.result = 'f';
        }
        VBS.debug_log('check resolution result: ' + this.result);
      },

      tracking: function() {
        VBS.log_values.push('res=' + screen.width + 'x' + screen.height);
        VBS.log_values.push('restest=' + this.result);
      }
    },

    flash: {
      name: 'flash',
      completed: false,
      result: null,
      disabled: false,
      fmajver: null,
      fminver: null,
      finstalled: null,

      check: function() {
        var version_obj = null;
        if (typeof swfobject !== "undefined") {
          version_obj = swfobject.getFlashPlayerVersion();
          if (version_obj.major === 0 ) {
            // flash is not installed
            this.result = 'f';
            this.finstalled = 'p';
            this.fmajver = '';
            this.fminver = '';
          } else {
            // flash is installed and enabled
            this.finstalled = 'p';
            this.fmajver = version_obj.major.toString();
            this.fminver = version_obj.minor.toString();
            // this actually checks for the '10.0' version and higher.
            if (swfobject.hasFlashPlayerVersion('10.0')) {
              this.result = 'p'; 
            } else {
              this.result = 'f';
            }
          } 

        } else {
          VBS.debug_log('*********************** swfobject failed to load');
          this.result = 'f';
          this.finstalled = 'f';
          this.fmajver = 'u';
          this.fminver = 'u';
        }
        var msg = this.result === true ? 'pass' : 'fail';
        VBS.debug_log('check flash result: ' + this.result);
      },

      tracking: function() {
        VBS.log_values.push('fmajver=' + this.fmajver);
        VBS.log_values.push('fminver=' + this.fminver);
        VBS.log_values.push('finstalled=' + this.finstalled);
        VBS.log_values.push('ftest=' + this.result);
      }
    },

    popup: {
      name: 'popup',
      completed: false,
      result: null,
      disabled: false,
      chrome_test_count: 0,
      chrome_test_max_iters: 60,

      check: function() {
        var that = this;
        var chrome_test_path = VBS.Resources.Urls.chromepopuptest;
        var popup = window.open(chrome_test_path,"popuptest","directories=no,height=100,width=100,menubar=no,resizable=no,scrollbars=no,status=no,titlebar=no,top=0,location=no");
        if (!popup || typeof popup.closed === 'undefined' ||  popup.closed || typeof popup === 'undefined') {
          VBS.debug_log('no popup object was returned to caller, so test fails');
          this.result = 'f';
        } else {
          if (VBS.Checks.browser_version.bname.toLowerCase() === "chrome") {
            // Chrome returns the window object to the caller when poppups are blocked,
            // so the popup itself needs to be tested
            VBS.debug_log('popup test in Chrome');

            (function pollchromepopup() {
              setTimeout(function(){
                var test_count = VBS.Checks.popup.chrome_test_count;
                var test_max = VBS.Checks.popup.chrome_test_max_iters;
                if (popup && popup.chrome_popups_permitted) {
                  VBS.debug_log('popup is loaded and the JS is functioning');
                  if (popup.chrome_popups_permitted()) {
                    VBS.debug_log('chrome has loaded the popup and JS test passed');
                    VBS.Checks.popup.result = 'p';
                  } else {
                    VBS.debug_log('chrome popup loaded and JS test failed');
                    VBS.Checks.popup.result = 'f';
                  }
                  VBS.debug_log('popups enabled in Chrome result: ' + VBS.Checks.popup.result);
                } else {
                  if (VBS.Checks.popup.chrome_test_count < VBS.Checks.popup.chrome_test_max_iters) {
                    VBS.debug_log('popup did not load in chrome, rechecking at iteration ' + VBS.Checks.popup.chrome_test_count + ' out of ' + VBS.Checks.popup.chrome_test_max_iters);
                    VBS.Checks.popup.chrome_test_count++;
                    pollchromepopup();
                    
                  } else {
                    VBS.debug_log('**********************  Cannot load chromepopup test file, abandoning');
                    VBS.Checks.popup.result = 'timeout';
                  }

                }

              }, 5);
            })();
          } else {
            VBS.debug_log('browser is not Chrome and the popup object is good to go.');
            this.result = 'p';
            popup.close();
            VBS.debug_log('popups enabled result: ' + this.result);
          }
        }
        
      },

      tracking: function() {
        VBS.debug_log('tracking in popup test');
        VBS.log_values.push('popupok=' + this.result);
      }
    }
  }
}

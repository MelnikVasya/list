//= require turbolinks
//= require jquery
//= require jquery-ui
//= require jquery_ujs
//= require jquery.turbolinks
//= require bootstrap-sprockets
//= require bootstrapValidator.min
//= require best_in_place
//= require jquery.purr
//= require best_in_place.purr
//= require jquery.datetimepicker
//= require unobtrusive_flash
//= require unobtrusive_flash_bootstrap
//= require_tree .

$(document).ready(function() {
  UnobtrusiveFlash.flashOptions['timeout'] = 6000; // milliseconds
  /* Activating Best In Place */
  $(".best_in_place").best_in_place();
  $('.new-project-header').bootstrapValidator({
    message: 'This value is not valid',
    feedbackIcons: {
      valid: 'glyphicon glyphicon-ok',
      invalid: 'glyphicon glyphicon-remove',
      validating: 'glyphicon glyphicon-refresh'
    },
    fields: {
      'task_list[header]': {
        validators: {
          notEmpty: {
            message: 'Name cannot be empty'
          },
          stringLength: {
            max: 140,
            message: 'Maximum name projact length is 140 characters'
          }
        }
      }
    }
  }).on('success.form.bv', function (e) {
    // Called when the form is valid
    var $form = $(e.target);
    if ($form.data('remote') && $.rails !== undefined) {
      e.preventDefault();
    }
  });

  $('#NewProjectModal').on('hide.bs.modal', function () {
    $('.new-project-header').bootstrapValidator('resetForm', true);
  }).on('show.bs.modal', function () {
    $('input.btn.btn-primary').prop('disabled', true);
  });

  $('.sign_in').bootstrapValidator({
    message: 'This value is not valid',
    feedbackIcons: {
      valid: 'glyphicon glyphicon-ok',
      invalid: 'glyphicon glyphicon-remove',
      validating: 'glyphicon glyphicon-refresh'
    },
    fields: {
      'session[email]': {
        validators: {
          notEmpty: {
            message: 'email cannot be empty'
          },
          emailAddress: {
            message: 'input is not a valid email address'
          }
        }
      },
      'session[password]': {
        validators: {
          notEmpty: {
            message: 'password cannot be empty'
          },
          stringLength: {
            max: 255,
            message: 'Maximum password length is 255 characters'
          },
          regexp: {
            regexp: /(?=^.{6,}$)((?=.*\d)|(?=.*\W+))(?![.\n])(?=.*[A-Z])(?=.*[a-z]).*$/,
            message: 'password (UpperCase, LowerCase, Number/SpecialChar and min 6 Chars)'
          }

        }

      }
    }
  });
  $('.sign_up').bootstrapValidator({
    message: 'This value is not valid',
    feedbackIcons: {
      valid: 'glyphicon glyphicon-ok',
      invalid: 'glyphicon glyphicon-remove',
      validating: 'glyphicon glyphicon-refresh'
    },
    fields: {
      'user[name]': {
        message: 'The username is not valid',
        validators: {
          notEmpty: {
            message: 'The username is required and cannot be empty'
          },
          stringLength: {
            min: 3,
            max: 15,
            message: 'The username must be more than 3 and less than 15 characters long'
          },
          regexp: {
            regexp: /^[a-zA-Z0-9_]+$/,
            message: 'The username can only consist of alphabetical, number and underscore'
          }
        }
      },
      'user[email]': {
        validators: {
          notEmpty: {
            message: 'The email is required and cannot be empty'
          },
          emailAddress: {
            message: 'The input is not a valid email address'
          }
        }
      },
      'user[password]': {
        validators: {
          notEmpty: {
            message: 'The password is required and cannot be empty'
          },
          stringLength: {
            max: 255,
            message: 'Maximum password length is 255 characters'
          },
          regexp: {
            regexp: /(?=^.{6,}$)((?=.*\d)|(?=.*\W+))(?![.\n])(?=.*[A-Z])(?=.*[a-z]).*$/,
            message: 'Password (UpperCase, LowerCase, Number/SpecialChar and min 6 Chars)'
          },
          identical: {
            field: 'user[password_confirmation]',
            message: 'The password and its confirm must be the same'
          }
        }
      },
      'user[password_confirmation]': {
        validators: {
          notEmpty: {
            message: 'The confirm password is required and cannot be empty'
          },
          identical: {
            field: 'user[password]',
            message: 'The password and its confirm must be the same'
          }
        }
      }
    }
  });

  $(".container-app").on('click', ".task-check", function () {
    $.ajax({
      url: '/tasks/' + this.value + '/toggle',
      type: 'POST',
      data: {"mark": this.checked}
    });
  });
  $(".container-app").on("mouseover", ".task", function () {
    $(this).children(".edit-task-group").addClass("show-edit-group");
  }).on("mouseout", ".task", function () {
    $(this).children(".edit-task-group").removeClass("show-edit-group");
  }).on("mouseover", ".todolist-header", function () {
    $(this).children(".editing-list").addClass("show-edit-group");
  }).on("mouseout", ".todolist-header", function () {
    $(this).children(".editing-list").removeClass("show-edit-group");
  }).on('shown.bs.dropdown', '.dropdown', function () {
    $(this).parent(".edit-task-group").addClass("show-edit-task-group-off");
  }).on('hide.bs.dropdown', '.dropdown', function () {
    $(this).parent(".edit-task-group").removeClass("show-edit-task-group-off");
  }).on("mouseover", ".deadline-create-task, .deadline", function () {
    $(this).datepicker({
      dateFormat: "yy/mm/dd",
      changeMonth: true,
      changeYear: true,
      showButtonPanel: true,
      closeText: 'Clear',
      onClose: function (dateText, inst) {
        if ($(window.event.srcElement).hasClass('ui-datepicker-close'))
          $(this).val('');
      }
    });
  });
  $('.task-list').sortable({
    axis: 'y',
    handle: 'p',
    update: function () {
      $.post('/task_lists/sort', $(this).sortable('serialize'));
    }
  });

});



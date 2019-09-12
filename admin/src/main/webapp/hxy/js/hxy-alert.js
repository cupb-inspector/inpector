/**
 * 弹出式提示框，默认1.2秒自动消失
 * @param message 提示信息
 * @param style 提示样式，有alert-success、alert-danger、alert-warning、alert-info
 * @param time 消失时间
 */
var prompt = function (message, style, time)
{
    style = (style === undefined) ? 'hxy-alert-success' : style;
    time = (time === undefined) ? 1200 : time;
    $('<div>')
        .appendTo('body')
        .addClass('alert ' + style)
        .html(message)
        .show()
        .delay(time)
        .fadeOut();
};

// 成功提示
var success_prompt = function(message, time)
{
    prompt(message, 'hxy-alert-success', time);
};

// 失败提示
var fail_prompt = function(message, time)
{
    prompt(message, 'hxy-alert-danger', time);
};

// 提醒
var warning_prompt = function(message, time)
{
    prompt(message, 'hxy-alert-warning', time);
};

// 信息提示
var info_prompt = function(message, time)
{
    prompt(message, 'hxy-alert-info', time);
};

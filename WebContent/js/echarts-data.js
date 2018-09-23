$(function () {
    // 填入对应日期
    var dateArr = getDate();

    $('#dateSearch-1').find('#date-start').val(dateArr[0]);
    $('#dateSearch-1').find('#date-end').val(dateArr[1]);
	$('.daterange').val(dateArr[0] + '-' + dateArr[1]);
    //图表数据接入
    var echart = new doEcharts('main', 'bar', G_BASE_URL + '?tag=customer,business&startDate=' + dateArr[0] + '&endDate=' + dateArr[1] + '&style=echarts');


    // 左侧菜单收缩重新渲染图表
    $('#sizeToggle,#menuToggle').click(function ()
    {       
        echart.render();
        //echart2.render();
        //echart3.render();
    });


    window.addEventListener("orientationchange", function ()
    {
        echart.render();
        //echart2.render();
        //echart3.render();
    }, false);
	window.addEventListener("resize", function ()
    {
        echart.render();
        //echart2.render();
        //echart3.render();
    }, false);

    var oEchart = $('.echart-date');

    for (var i = 0, j = oEchart.length; i < j; i++) 
    {
        (function (i) {
            oEchart[i].onclick = function (ev) {

                var ev = ev || window.event;
                var target = ev.targe || ev.srcElement;
                if (ev.target.nodeName.toLocaleLowerCase() == "span") {
                    var startDate = $(this).find('#date-start').val(),
                        endDate = $(this).find('#date-end').val(),
                        aEchart = '';
                    i > 0 ? aEchart = eval('echart' + (i + 1)) : aEchart = eval(aEchart = 'echart');
                    var url = aEchart.url.substring(0, aEchart.url.search(/&/)) + '&startDate=' + startDate + '&endDate=' + endDate + '&style=echarts';
                    aEchart.initEcharts(url);
                }
            };
        })(i);
    }
});

function getDate() {
    var date = new Date(),
        Year = 0,
        beforeYear = 0,
        Month = 0,
        beforeSixMonth = 0,
        Day = 0,
        stratDate = "",
        endDate = "",
        stratDateM = "",
        endDateM = "",
        arr = [];

    Year = date.getFullYear();
    Month = date.getMonth() + 1;
    Day = date.getDate();
	stratDate = Year + '-' + Month + '-01';
    endDate = Year + '-' + Month + '-' + Day;
    arr.push(stratDate, endDate);
    return arr;
}
function doEcharts(element, type, url, options) {
    this.element = element;
    this.type = type;
    this.url = url;
    this.options = {
        //animation: false,
        //addDataAnimation: false,
        grid: {
            x: 45,
            y: 65,
            x2: 15,
            y2: 35,
            backgroundColor: '#fff',
            borderColor: '#fff'
        },
        calculable: false,
        tooltip : {
            trigger: 'axis'
        },
        yAxis: [{
            type: 'value',
            splitLine: {
                show: true,
                lineStyle: {
                    color: 'rgba(0,0,0,0.1)',
                    type: 'dashed',
                    width: 1
                }
            }
        }]
    };
    this.options = $.extend(this.options, options);
    this.initEcharts(this.url)
}
doEcharts.prototype = {
    initEcharts : function (url) {
        this.getData(url);
    },

    getData:function(url) {
        var _this = this;
        if (url) {
            $.get(url, {
                'async': false
            }, function (result) {
                if (result) {
                    var xAxis = _this.initxAxis(result.labels),
                        legend = _this.getUrlParam('tag'),
                        series = _this.initSeries(_this.type, result.data);
                    _this.options = $.extend(_this.options, xAxis, series, legend);
                    _this.render(_this.element);
                }
            }, 'json');
        }
    },
    render: function () {
        var _option = this.options;
        var _element = this.element;
        var _type = this.type;
        Wind.use('echarts', function(){
            require.config({
                paths: {
                    echarts: GV.JS_ROOT + 'js/echarts',
                    'chart/bar': GV.JS_ROOT + 'js/echarts',
                    'chart/line': GV.JS_ROOT + 'js/echarts',
                    'chart/pie': GV.JS_ROOT + 'js/echarts'
                }
            });
            require(['echarts',// 这里定义项目中需要的类
                'echarts/chart/' + _type], function (ec) {
                var myChart = ec.init(document.getElementById(_element));
                myChart.setOption(_option);
            });
        });
    },

    initxAxis : function(labels) {
        var options = {
            xAxis: [{
                type: 'category',
                data: labels
            }]
        };
        return options;
    },
    getUrlParam : function(name){
        var star_flag = this.url.search(name) + name.length + 1,
            end_flag = this.url.search(/&/),
            param = this.url.substring(star_flag, end_flag).split(',');
        arr = [];

        for (var i = 0; i < param.length; i++) {
            switch (param[i]) {
                case 'customer':
                    arr.push('新增客户');
                    break;

                case 'business':
                    arr.push('新增商机');
                    break;

                case 'sales':
                    arr.push('销售单');
                    break;
            }
        }
        var options = {
            legend: {
                data: arr,
                padding: 8,
                x: 'right',
                boundaryGap : false
            }
        }

        this.legend_data = arr;
        return options;
    },
    initSeries : function(type, data) {

        if (data) {
            arr = [];

            for (var i = 0; i < data.length; i++) {
                var j = {
                    name: this.legend_data[i],
                    type: this.type,
                    data: data[i]
                }
                arr.push(j);
            }
            var options = {
                series: arr
            }

            return options;
        }
    }
}
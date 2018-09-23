layui.use(['layer', 'element'], function() {
    var url = 'welcome.html',
        layer = layui.layer,
        $ = layui.jquery;
    if (window.sessionStorage.getItem('url')) {
        url = window.sessionStorage.getItem('url');
    }
    var element = layui.element(); //导航的hover效果、二级菜单等功能，需要依赖element模块
    myloadNewpage(url);
    //监听导航点击
    element.on('nav(test)', function(elem) { //通过url更改页面       
        window.sessionStorage.setItem('url', $(elem[0]).attr('name'));
        myloadNewpage($(elem[0]).attr('name'))
    });

    //页面切换方法
    function myloadNewpage(url) {
        $.ajaxSetup({ cache: false }); //不存入缓存
        $('#myContent').load(url); //加载页面
    };

    // 消息通知
    var noticeIndex = null;
    // setInterval(function() {
        // noticeIndex = layer.open({
        //     type: 1,
        //     title: '新信息提醒', // 标题
        //     area: '340px',
        //     offset: 'rb',
        //     content: $('#notice'),
        //     shade: 0,
        //     resize: false,
        //     move: false,
        //     time: 3000,
        //     end: function() {
        //         $('#notice').css('display', 'none');
        //         noticeIndex = null;
        //     }
        // });
    // }, 5000);
    const URL = 'pages/NewsManagement/evaluateManagement/evaluateManagement.html';
    // 查看全部信息
    $('#notice .notice_Btn').click(function() {
        if (window.sessionStorage.getItem('url') !== URL) { // 当前页面不是消息管理页面，先跳转到消息管理页面
            noticePage(true);
        }
        layer.close(noticeIndex);
    });
    // 查看某条信息
    $('#notice .notice_view').on('click', function() {
        if (window.sessionStorage.getItem('url') !== URL) { // 当前页面不是消息管理页面，先跳转到消息管理页面，再弹出详情
            noticePage(false);
        } else { //当前页面已经是消息管理页面，直接弹出详情
            noticeModal()
        }
    });

    function noticePage(temp) {
        window.sessionStorage.setItem('url', URL);
        $.ajaxSetup({ cache: false });
        if (temp) {
            $('#myContent').load(URL);
        } else {
            $('#myContent').load(URL, function() {
                noticeModal();
            });
        }
        // 切换菜单栏效果
        if (!$('#notice_active').parents('li').hasClass('layui-nav-itemed')) {
            $('#notice_active').parents('li').addClass('layui-nav-itemed');
        }
        $('.layui-nav dd').removeClass('layui-this');
        $('#notice_active').addClass('layui-this');
    }

    function noticeModal() {
        layer.open({
            type: 1,
            title: '查看消息信息', // 标题
            skin: 'layui-layer-lan', //弹框主题
            area: '800px', //宽高
            content: $('#evaluateModel'),
            shade: 0,
            resize: false,
            move: false,
            end: function() {
                $('#evaluateModel').css('display', 'none');
            }
        });
    }
});
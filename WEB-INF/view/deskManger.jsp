<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8">
    <title>工作台</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="format-detection" content="telephone=no">
    <link rel="stylesheet" href="/HangCaiCarRental/resources/layui/css/layui.css" media="all"/>
    <link rel="stylesheet" href="/HangCaiCarRental/resources/css/public.css" media="all"/>
</head>
<blockquote class="layui-elem-quote layui-bg-green">
    <div id="nowTime"></div>
</blockquote>
<form class="layui-form" method="post" id="searchFrm">
    <div class="layui-inline">
        <button type="button"
                class="layui-btn layui-btn-normal layui-icon layui-icon-search layui-btn-radius layui-btn-sm"
                id="doSearch" style="margin-top: 4px">查询门店未处理通知
        </button>
        <button type="button"
                class="layui-btn layui-btn-warm layui-icon layui-icon-refresh layui-btn-radius layui-btn-sm"
                id="doSearch2" style="margin-top: 4px">查询门店已处理通知
        </button>
    </div>
</form>
<table class="layui-hide" id="carTable" lay-filter="carTable"></table>
<div id="carBar" style="display: none;">
    <a class="layui-btn layui-btn-warm layui-btn-xs layui-btn-radius" lay-event="viewNews">查看</a>
    <a class="layui-btn layui-btn-danger layui-btn-xs layui-btn-radius" lay-event="del">已解决</a>
</div>

<%--查看公告的div--%>
<div id="viewNewsDiv" style="padding: 10px;display: none">
    <h2 id="view_title" align="center"></h2>
    <hr>
    <div style="text-align: right">
        <%--        <span id="view_opername"></span>--%>
        <span style="display: inline-block;width: 20px"></span>
        通知时间:<span id="view_createtime"></span>
    </div>
    <hr>
    <div id="view_content"></div>
</div>
<script type="text/javascript" src="/HangCaiCarRental/resources/layui/layui.js"></script>
<script>

    //获取系统时间
    var newDate = '';
    getLangDate();
    viewNews(18)

    //值小于10时，在前面补0
    function dateFilter(date) {
        if (date < 10) {
            return "0" + date;
        }
        return date;
    }

    function getLangDate() {
        var dateObj = new Date(); //表示当前系统时间的Date对象
        var year = dateObj.getFullYear(); //当前系统时间的完整年份值
        var month = dateObj.getMonth() + 1; //当前系统时间的月份值
        var date = dateObj.getDate(); //当前系统时间的月份中的日
        var day = dateObj.getDay(); //当前系统时间中的星期值
        var weeks = ["星期日", "星期一", "星期二", "星期三", "星期四", "星期五", "星期六"];
        var week = weeks[day]; //根据星期值，从数组中获取对应的星期字符串
        var hour = dateObj.getHours(); //当前系统时间的小时值
        var minute = dateObj.getMinutes(); //当前系统时间的分钟值
        var second = dateObj.getSeconds(); //当前系统时间的秒钟值
        var timeValue = "" + ((hour >= 12) ? (hour >= 18) ? "晚上" : "下午" : "上午"); //当前时间属于上午、晚上还是下午
        newDate = dateFilter(year) + "年" + dateFilter(month) + "月" + dateFilter(date) + "日 " + " " + dateFilter(hour) + ":" + dateFilter(minute) + ":" + dateFilter(second);
        document.getElementById("nowTime").innerHTML = timeValue + "好！ 欢迎使用航财汽车租赁管理系统。当前时间为： " + newDate + "　" + week;
        setTimeout("getLangDate()", 1000);
    }

    layui.use(['form', 'element', 'layer', 'jquery'], function () {
        var form = layui.form,
            layer = parent.layer === undefined ? layui.layer : top.layer,
            element = layui.element;
        $ = layui.jquery;
        //上次登录时间【此处应该从接口获取，实际使用中请自行更换】
        $(".loginTime").html(newDate.split("日")[0] + "日</br>" + newDate.split("日")[1]);
        //icon动画
        $(".panel a").hover(function () {
            $(this).find(".layui-anim").addClass("layui-anim-scaleSpring");
        }, function () {
            $(this).find(".layui-anim").removeClass("layui-anim-scaleSpring");
        })
        $(".panel a").click(function () {
            parent.addTab($(this));
        })
    })

</script>
<script type="text/javascript">
    var tableIns;
    layui.use(['jquery', 'layer', 'form', 'table', 'upload'], function () {
        var $ = layui.jquery;
        var layer = layui.layer;
        var form = layui.form;
        var table = layui.table;
        var dtree = layui.dtree;
        var upload = layui.upload;
        //渲染数据表格
        tableIns = table.render({
            elem: '#carTable'   //渲染的目标对象
            , url: '/HangCaiCarRental/storeNotification/notProcessedStoreNotification' //数据接口
            , title: '车辆数据表'//数据导出来的标题
            , toolbar: "#carToolBar"   //表格的工具条
            , height: 'full-205'
            , cellMinWidth: 100 //设置列的最小默认宽度
            , page: true  //是否启用分页
            , cols: [[   //列表数据
                // {type: 'checkbox', fixed: 'left'}
                {field: 'storeNotificationNumber', title: '通知单号', align: 'center', width: '250'}
                , {field: 'notificationTime', title: '通知时间', align: 'center', width: '200'}
                , {field: 'storeInformation', title: '信息', align: 'center', width: '500'}
                , {
                    field: 'resolveSituation', title: '解决情况', align: 'center', width: '90', templet: function (d) {
                        if (d.resolveSituation == '未解决') {
                            return '<font color=red>未解决</font>';
                        } else {
                            return '<font color=green>已解决</font>';
                        }
                        // return d.isrenting == '已入库' ? '<font color=blue>已出租</font>' : '<font color=red>未出租</font>';
                    }
                }

                , {fixed: 'right', title: '操作', toolbar: '#carBar', align: 'center', width: '150'}
            ]],
            done: function (data, curr, count) {
                //不是第一页时，如果当前返回的数据为0那么就返回上一页
                if (data.data.length == 0 && curr != 1) {
                    tableIns.reload({
                        page: {
                            curr: curr - 1
                        }
                    })
                }
            }
        });

        //模糊查询
        $("#doSearch").click(function () {
            // var params = $("#searchFrm").serialize();
//            alert(params);
            tableIns.reload({
                url: "/HangCaiCarRental/storeNotification/notProcessedStoreNotification",
                page: {curr: 1}
            })
        });
        //模糊查询
        $("#doSearch2").click(function () {
            // var params = $("#searchFrm").serialize();
//            alert(params);
            tableIns.reload({
                url: "/HangCaiCarRental/storeNotification/processedStoreNotification",
                page: {curr: 1}
            })
        });
        $("#doEsSearch").click(function () {
            var params = $("#esSearchFrm").serialize();
//            alert(params);
            tableIns.reload({
                url: "/HangCaiCarRental/car/esFuzzyQuery?" + params,
                page: {curr: 1}
            })
        });
        //导出
        $("#doExport").click(function () {
            var params = $("#searchFrm").serialize();
            window.location.href = "/HangCaiCarRental/stat/exportCar?" + params;
        });
        //监听头部工具栏事件
        table.on("toolbar(carTable)", function (obj) {
            switch (obj.event) {
                case 'add':
                    openAddCar();
                    break;
                case 'deleteBatch':
                    deleteBatch();
                    break;
            }
        });

        //监听行工具事件
        table.on('tool(carTable)', function (obj) {
            var data = obj.data; //获得当前行    数据
            var layEvent = obj.event; //获得 lay-event 对应的值（也可以是表头的 event 参数对应的值）
            if (layEvent === 'del') { //删除
                layer.confirm('确认已处理完毕： ' + data.storeInformation + ' 这个通知？', function (index) {
                    //向服务端发送删除指令
                    $.post("/HangCaiCarRental/storeNotification/updateCompleted", {storeNotificationId: data.storeNotificationId}, function (res) {
                        layer.msg(res.msg);
                        //刷新数据表格
                        tableIns.reload();
                    })
                });
            } else if (layEvent === 'edit') { //编辑
                //编辑，打开修改界面
                openUpdateCar(data);
            } else if (layEvent === 'viewNews') { //查看
                viewNews(data);
            }
        });

        var url;
        var mainIndex;

        //查看
        function viewNews(data) {
            mainIndex = layer.open({
                type: 1,
                title: '查看公告',
                content: $("#viewNewsDiv"),
                area: ['700px', '540px'],
                success: function (index) {
                    $("#view_title").html(data.storeNotificationNumber);
                    // $("#view_opername").html(data.opername);
                    $("#view_createtime").html(data.notificationTime);
                    $("#view_content").html(data.storeInformation);
                }
            });
        }

        //打开添加页面
        function openAddCar() {
            mainIndex = layer.open({
                type: 1,
                title: '添加车辆',
                content: $("#saveOrUpdateDiv"),
                area: ['700px', '480px'],
                success: function (index) {
                    //清空表单数据
                    $("#dataFrm")[0].reset();
                    //设置默认图片
                    $("#showCarImg").attr("src", "/HangCaiCarRental/file/downloadShowFile?path=images/defaultcarimage.jpg");
                    $("#carimg").val("images/defaultcarimage.jpg");
                    url = "/HangCaiCarRental/car/addCar";
                    $("#carnumber").removeAttr("readonly", "readonly");
                }
            });
        }

        //打开修改页面
        function openUpdateCar(data) {
            mainIndex = layer.open({
                type: 1,
                title: '修改车辆',
                content: $("#saveOrUpdateDiv"),
                area: ['700px', '480px'],
                success: function (index) {
                    form.val("dataFrm", data);
                    $("#showCarImg").attr("src", "/HangCaiCarRental/file/downloadShowFile?path=" + data.carimg);
                    url = "/HangCaiCarRental/car/updateCar";
                    $("#carnumber").attr("readonly", "readonly");
                }
            });
        }

        //保存
        form.on("submit(doSubmit)", function (obj) {
            //序列化表单数据
            var params = $("#dataFrm").serialize();
            $.post(url, params, function (obj) {
                layer.msg(obj.msg);
                //关闭弹出层
                layer.close(mainIndex)
                //刷新数据 表格
                tableIns.reload();
            })
        });

        //批量删除
        function deleteBatch() {
            //得到选中的数据行
            var checkStatus = table.checkStatus('carTable');
            var data = checkStatus.data;
            var params = "";
            $.each(data, function (i, item) {
                if (i == 0) {
                    params += "ids=" + item.storeNotificationId;
                } else {
                    params += "&ids=" + item.storeNotificationId;
                }
            });
            layer.confirm('真的要删除这些车辆么？', function (index) {
                //向服务端发送删除指令
                $.post("/HangCaiCarRental/car/deleteBatchCar", params, function (res) {
                    layer.msg(res.msg);
                    //刷新数据表格
                    tableIns.reload();
                })
            });
        }

        //上传缩略图
        upload.render({
            elem: '#carimgDiv',
            url: '/HangCaiCarRental/file/uploadFile',
            method: "post",  //此处是为了演示之用，实际使用中请将此删除，默认用post方式提交
            acceptMime: 'images/*',
            field: "mf",
            done: function (res, index, upload) {
                $('#showCarImg').attr('src', "/HangCaiCarRental/file/downloadShowFile?path=" + res.data.src);
                $('#carimg').val(res.data.src);
                $('#carimgDiv').css("background", "#fff");
            }
        });

        //查看大图
        function showCarImage(data) {
            mainIndex = layer.open({
                type: 1,
                title: "【" + data.carNumber + '】的车辆图片',
                content: $("#viewCarImageDiv"),
                area: ['750px', '500px'],
                success: function (index) {
                    $("#view_carimg").attr("src", "/HangCaiCarRental/file/downloadShowFile?path=" + data.carimg);
                }
            });
        }

    });

</script>

</body>
</html>

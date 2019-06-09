<%--
  Created by IntelliJ IDEA.
  User: Freddy
  Date: 2019-02-24
  Time: 10:06
  To change this template use File | Settings | File Templates.
--%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>test</title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="Author" content="阮家友，韩飞宇">
    <meta name="Keywords" content="HTML,model,test">
    <meta name="Description" content="special effect">
    <style type="text/css">
        html,body{font-size:14px;margin:0px;padding:0px;}
        li {list-style:none;}
        img {border:0px;}
        a {text-decoration:none;}
    </style>
</head>

<body>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
<script type="text/javascript">
    var ddd=0;

    //获取分类信息的数据
    $(function(){
        console.log("fail");
        $.ajax({
            type:'post',
            url: "/testmysql",
            callbackParameter:"callback",
            dataType:'text',  //这里如果换成json格式，会出错。

            // dataFilter:function(json){ //对json进行预处理，然后在提交到success函数
            //     console.log("jsonp.filter:"+json);
            //     return json;
            // },
            success: function(resp){ //resp获得的是对象或者数
                //alert("aaaaa");
                console.log("data success!");
                //var data=$.parseJSON(resp);
                //console.log(data.toString());
                // $.each(eval('('+resp+')'), function (index, item) {
                //     //index为序号，相对于json格式的resp而言，从0，1，2，3...到Result的长度减1，item就是每条jsonObject，
                //     //取值就是：item.属性名，如item.name, item.id, item.number.....
                //     console.log("data summit success");
                //     //console.log(JSON.stringify(resp));
                //
                // });
            },
            error : function(xhr, status, errMsg)
            {
                alert("data summitted error!");
            }

    });
    });


</script>


</body>
</html>



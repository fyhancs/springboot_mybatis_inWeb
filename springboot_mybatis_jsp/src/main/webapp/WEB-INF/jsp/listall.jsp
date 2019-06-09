<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>  <!-- 导入的mysql驱动包 -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
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
        .clear {clear:both;}

        #center {width:1600px;margin:0 auto;padding-top:50px;position:relative;}
        #c1 {
            position: absolute;
            left: 0px;
            top: 0px;
            margin: 20px;
            background-color:#333;
        }
        #c2 {
            position: absolute;
            left: 0px;
            top: 0px;
            margin: 20px;
            border: thin solid #aaaaaa;
        }
    </style>
</head>

<body>
    <div id="center">
        <canvas id="c1" width="1200px" height="800px"></canvas><br/>
        <canvas id="c2" width="1200px" height="800px"></canvas><br/>
    </div>


<script type="text/javascript">


//二维向量 可表示位置position(x,y)  速度 v(Vx,Vy) 加速度a(Gx,Gy)
Vector2 = function(x, y) { this.x = x; this.y = y; };
var degree=0;
function CreateCanvasObject(canvasId,func){
    //返回的对象 包含节点Node 绘图环境GC 等属性 和 clear 等方法
    var obj = new Object();
    var ocanvas = document.getElementById(canvasId);
    var ocolor='';
    if(ocanvas.currentStyle)
		ocolor = ocanvas.currentStyle['backgroundColor'];
	else
        ocolor = getComputedStyle(ocanvas,false)['backgroundColor'];

    //这里要做判断 是否获取到canvas标签 否则返回 null
    //获取画布绘图环境
    var ocanvasGC = ocanvas.getContext('2d');
    obj =
    {
        Node:ocanvas,
        GC:ocanvasGC,
        timer:'',
        bContinue:false,
        fun:func,
        color:ocolor,
        clear:function(){this.GC.clearRect(0,0,this.Node.width,this.Node.height);},
        start1:function(){
            var oThis = this;
            if(oThis.timer)
            {
                oThis.stop();
            }
            oThis.bContinue = true;
            var loop = function()
            {
                oThis.fun(oThis);
                if(oThis.bContinue)
                {
                    oThis.timer = setTimeout(loop,10);
                }
            }

            loop();
        },
        start2:function(){
            var oThis = this;
            if(oThis.timer)
            {
                oThis.stop();
            }
            oThis.bContinue = true;
            var loop = function()
            {
                oThis.fun(oThis);
                if(oThis.bContinue)
                {
                    oThis.timer = setTimeout(loop,1500);
                }
            }
            loop();
        },
        stop:function(){clearTimeout(this.timer);this.bContinue = false;}
    }
    return obj;
}

Vector2.prototype = {
    copy : function() { return new Vector2(this.x, this.y); },
    length : function() { return Math.sqrt(this.x * this.x + this.y * this.y); },
    sqrLength : function() { return this.x * this.x + this.y * this.y; },
    normalize : function() { var inv = 1/this.length(); return new Vector2(this.x * inv, this.y * inv); },
    negate : function() { return new Vector2(-this.x, -this.y); },
    add : function(v) { return new Vector2(this.x + v.x, this.y + v.y); },
    subtract : function(v) { return new Vector2(this.x - v.x, this.y - v.y); },
    multiply : function(f) { return new Vector2(this.x * f, this.y * f); },
    divide : function(f) { var invf = 1/f; return new Vector2(this.x * invf, this.y * invf); },
    dot : function(v) { return this.x * v.x + this.y * v.y; }
};

function draw_background(obj){
    //采用叠加递减效果
    obj.GC.fillStyle = "rgba(0,0,0,0.03)";
    obj.GC.fillRect(0,0,obj.Node.width,obj.Node.height);
    obj.GC.strokeStyle='#72d6fc';

    var halfW = obj.Node.width/2;
    var halfH = obj.Node.height/2;

    //扩散波动圆
    obj.GC.lineWidth=1;
    for(var k=0;k<5;k++){
        obj.GC.beginPath();
        obj.GC.arc(halfW,halfH,r1+k,0,Math.PI*2,'#72d6fc',true);
        obj.GC.closePath();
        obj.GC.stroke();

        obj.GC.beginPath();
        if(!bFirst)
            obj.GC.arc(halfW,halfH,r2+k,0,Math.PI*2,'#72d6fc',true);
        obj.GC.closePath();
        obj.GC.stroke();
    }
    if(r1 > R){
        r1=0;
    }
    if(r2 > R){
        r2 = 0;
        if(bFirst==true){
            bFirst=false;
        }
    }
    r1++,r2++;

    //旋转扫描线
    obj.GC.lineWidth=6;
    obj.GC.save();
    obj.GC.translate(obj.Node.width/2,obj.Node.height/2);
    obj.GC.rotate(degree*Math.PI/180);
    obj.GC.beginPath();
    obj.GC.moveTo(0,-3);
    obj.GC.lineTo(0,R);
    obj.GC.closePath();
    obj.GC.stroke();
    obj.GC.restore();
    //开始画网格
    for(var i=0;i<obj.Node.width;i+=10){
        line(obj.GC,'#7266fc',0.5,i+0.5,0,i+0.5,obj.Node.height);
    }
    for(var j=0;j<obj.Node.height;j+=10){
        line(obj.GC,'#7266fc',0.5,0,j+0.5,obj.Node.width,j+0.5);
    }

    //中心小圆点
    obj.GC.fillStyle = '#c00';
    obj.GC.beginPath();
    obj.GC.arc(halfW,halfH,6,0,Math.PI*2,true);
    obj.GC.closePath();
    obj.GC.fill();
    degree++;
}
//画线方法封装
function line(gc,color,width,startX,startY,endX,endY){
    gc.strokeStyle = color;
    gc.lineWidth=width;
    gc.beginPath();
    gc.moveTo(startX,startY);
    gc.lineTo(endX,endY);
    gc.closePath();
    gc.stroke();
}

var obj1 = CreateCanvasObject('c1',draw_background);
var R = Math.sqrt(Math.pow(obj1.Node.width/2,2)+Math.pow(obj1.Node.height/2,2));
var r1=0,r2=R/2,bFirst=true;
//页面打开自动运行
obj1.start1();
</script>


<script type="text/javascript">
var location_x=300;
var location_y=200;
var location_data=[
    637.397813,442.746431,
    612.236653,353.040112,
    624.657102,367.792305,
    646.850523,373.864354,
    628.856865,406.950850,
    629.064516,389.943348,
    633.256362,372.438258,
    619.757877,408.216922,
    619.157607,408.665286,
    618.926125,401.997086,
];
var aoa=[16.56,-39.015,-32.333334,-22.5,-12.33,-9.757895,-16.4,3.535714,-9, 0.105131,-34.725];
var index_loc=0;
var index_aoa=0;

function clear_canvas(){
    var c=document.getElementById("c2");
    var cxt=c.getContext("2d");
    c.height=c.height;
}
function draw_point(obj2){
    clear_canvas();
    var halfW = obj2.Node.width/2;
    var halfH = obj2.Node.height/2;
    //绘制位置信息
    // obj2.GC.font = '15px Arial';
    // obj2.GC.fillStyle = '#c00';
    // obj2.GC.fillText("angle:",location_data[index_loc]+10,location_data[index_loc+1]+10)
    //obj2.GC.fillText(aoa[index_aoa], location_data[index]+30,location_data[index+1]+10);


    obj2.GC.fillStyle = "#fff"; //设置描边样式
    obj2.GC.font = "20px Arial"; //设置字体大小和字体
    //绘制字体，并且指定位置
    obj2.GC.fillText("angle: "+aoa[index_aoa], location_data[index_loc]+10,location_data[index_loc+1]+10);
    index_aoa++;

    obj2.GC.save();
    obj2.GC.fillStyle = '#c00';
    obj2.GC.beginPath();
    obj2.GC.arc(location_data[index_loc],location_data[index_loc+1],4,0,Math.PI*2,true);
    obj2.GC.closePath();
    obj2.GC.fill();
    obj2.GC.restore();
    index_loc=index_loc+2;
}
var obj2 = CreateCanvasObject('c2',draw_point);
//页面打开自动运行
obj2.start2();

</script>
</body>
</html>


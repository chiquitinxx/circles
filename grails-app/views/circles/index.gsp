<!DOCTYPE HTML>
<html>
<head>
    <title>Grooscript grails 3 circles demo</title>
    <style>
        body {
            margin: 0px;
            padding: 0px;
        }
        #circlesCanvas {
            border: 1px;
            border-color: black;
        }
    </style>
    <asset:javascript src="jquery-2.1.3.js" />
    <asset:javascript src="spring-websocket" />
    <asset:javascript src="grooscript-grails" />
</head>

<body>
    <canvas id="circlesCanvas" width="1024" height="768"></canvas>

<grooscript:remoteModel domainClass="Circle"/>

<grooscript:initSpringWebsocket>
    println 'Connected! Websocket is up!'
    Circle.list(listCirclesProperties).then { list ->
        if (list) {
            list.each { circle ->
                drawCircle circle
            }
        } else {
            GrooscriptGrails.doRemoteCall('circles', 'randomCircle', null, null, { println "Error randomCircle" })
        }
    }
</grooscript:initSpringWebsocket>

<grooscript:onServerEvent path="/topic/newCircle">
    drawCircle data
</grooscript:onServerEvent>

<grooscript:code>
    def clickOnCanvas(event) {
        GrooscriptGrails.doRemoteCall('circles', 'positionCircle',
            [x: event.pageX, y: event.pageY], null, { println "Error positionCircle" })
    }
</grooscript:code>

<asset:script>
    var listCirclesProperties = {max: 1000};
    var canvas = document.getElementById('circlesCanvas');
    canvas.width = document.body.clientWidth;
    canvas.height = document.body.clientHeight;
    var context = canvas.getContext('2d');

    $('#circlesCanvas').click(clickOnCanvas);

    function drawCircle(circle) {
      context.beginPath();
      context.arc(circle.x, circle.y, circle.radius, 0, 2 * Math.PI, false);
      context.fillStyle = circle.color;
      context.fill();
      context.lineWidth = 5;
      context.strokeStyle = '#003300';
      context.stroke();
    }
</asset:script>

<asset:deferredScripts/>
</body>
</html>
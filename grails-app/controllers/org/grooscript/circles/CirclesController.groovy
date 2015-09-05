package org.grooscript.circles

import org.grooscript.circles.domain.Circle
import org.springframework.messaging.simp.SimpMessagingTemplate

class CirclesController {

    static final colors = ['#001F3F', '#0074D9', '#7FDBFF', '#39CCCC', '#3D9970',
                           '#2ECC40', '#01FF70', '#FFDC00', '#FF851B', '#FF4136',
                           '#F012BE', '#B10DC9', '#85144B']

    SimpMessagingTemplate brokerMessagingTemplate

    def index() { }

    def randomCircle() {
        def random = new Random()
        def circle = new Circle(x: random.nextInt(500) + 50, y: random.nextInt(500) + 50,
                radius: randomRadius, color: randomColor).save(flush: true, failOnError: true)
        broadcastNewCircle circle
        render 'Ok'
    }

    def positionCircle(int x, int y) {
        def circle = new Circle(x: x, y: y, radius: randomRadius, color: randomColor)
        circle.save(flush: true, failOnError: true)
        broadcastNewCircle circle
        render 'Ok'
    }

    private int getRandomRadius() {
        def random = new Random()
        random.nextInt(75) + 25
    }

    private String getRandomColor() {
        def random = new Random()
        colors[random.nextInt(colors.size())]
    }

    private broadcastNewCircle(Circle circle) {
        brokerMessagingTemplate.convertAndSend "/topic/newCircle", circle.asMap()
    }
}

package org.grooscript.circles.domain

import grails.rest.Resource

@Resource(uri='/circle', readOnly=true, formats=['json'])
class Circle {

    Integer x
    Integer y
    String color
    BigDecimal radius

    static constraints = {
        radius min: 10.0
    }

    Map asMap() {
        [x: x, y: y, color: color, radius: radius]
    }
}

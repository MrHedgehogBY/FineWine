<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<html>
<head>
    <title>Cart</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/main.css">
</head>
<body>
    <tags:header cart="${cart}"/>
    <h3>
        Your cart:
    </h3>
    <c:if test="${not empty isEmpty}">
        <h3>Your cart is empty!</h3>
    </c:if>
    <c:if test="${empty isEmpty}">
        <form:form id="update-form" method="post" action="${pageContext.request.contextPath}/cart" commandName="productArrayDTO">
            <div id="vertical-products-cart">
                <c:forEach var="i" begin="0" end="${cart.cartItems.size() - 1}">
                    <div id="horizontal-cart">
                        <div><img id="image" src="${cart.cartItems.get(i).product.picturePath}"></div>
                        <div><c:out value="${cart.cartItems.get(i).product.productName}"/></div>
                        <div><c:out value="${cart.cartItems.get(i).product.price}"/>$</div>
                        <div>
                            <form:input path="productDTOItems[${i}].id" type="hidden"/>
                            <form:input path="productDTOItems[${i}].quantity"/>
                            <br>
                            <form:errors path="productDTOItems[${i}].quantity" cssClass="red-res"/>
                            <span class="green-res"><c:out value="${fn:contains(updatedProductIds, cart.cartItems.get(i).product.id) ? successfulUpdateMessage : ''}"/></span>
                        </div>
                        <div>
                            <button class="buttons" formmethod="post" formaction="${pageContext.request.contextPath}/cart/${cart.cartItems.get(i).product.id}">
                                Delete from cart
                            </button>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </form:form>
        <div id="cart-buttons">
            <button class="buttons" id="update-cart" form="update-form">
                Update
            </button>
        </div>
        <form id="to-order-form" action="${pageContext.request.contextPath}/order?orderType=Delivery">
            <div class="items-inline">
                <label for="order-type">Choose order type:&nbsp</label><select name="orderType" id="order-type">
                    <c:forEach items="${orderTypes}" var="orderType">
                        <option>${orderType.name()}</option>
                    </c:forEach>
                </select>
                &nbsp
                <button class="buttons" id="order-cart" form="to-order-form">
                    Order
                </button>
            </div>
        </form>
    </c:if>

</body>
</html>

<script type="text/javascript">
    document.addEventListener('DOMContentLoaded',function(){
        document.getElementById('order-type').onchange = function(){
            var value = this.value || "Delivery";
            document.forms[1].action='${pageContext.request.contextPath}/order?orderType=' + value;
        }
        document.forms[1].onsubmit = function(){
            if(this.action) return true;
            return false;
        }
    });
</script>

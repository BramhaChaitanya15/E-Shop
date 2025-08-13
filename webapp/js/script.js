var x = 0;
var q = 1;
$(document).ready(function () {
    x = document.getElementById("q").innerHTML;
    const plus = document.querySelector(".plus"),
            minus = document.querySelector(".minus"),
            num = document.querySelector(".num");
    let a = 1;
    plus.addEventListener("click", () => {
        if (a < x) {
            a++;
            num.innerHTML = a;
            q = a;
        }
    });
    minus.addEventListener("click", () => {
        if (a > 1) {
            a--;
            num.innerHTML = a;
            q = a;
        }
    });
});
function addToCart(pid, pname, price, totalPquantity) {
    var quantity = q;
    add_to_cart(pid, pname, price, totalPquantity, quantity);
}

function add_to_cart(pid, pname, price, totalpquantity, quantity)
{
    if (quantity !== 0) {
        let cart = localStorage.getItem("cart");
        if (cart === null)
        {
            //no cart yet  
            //Product is added for the first time
            let products = [];
            let product = {productId: pid, productName: pname, productQuantity: quantity, productPrice: price};
            products.push(product);
            localStorage.setItem("cart", JSON.stringify(products));
            showToast("Item is added to cart");
        } else {
            //cart is already present
            let pcart = JSON.parse(cart);
            let oldProduct = pcart.find((item) => item.productId === pid);
            console.log(oldProduct);
            if (oldProduct) {
                //we have to increase the quantity
                oldProduct.productQuantity = oldProduct.productQuantity + quantity;
                if (oldProduct.productQuantity <= totalpquantity) {
                    pcart.map((item) => {
                        if (item.productId === oldProduct.productId)
                        {
                            item.productQuantity = oldProduct.productQuantity;
                        }
                    });
                    localStorage.setItem("cart", JSON.stringify(pcart));
                    //console.log("Product quantity is increased");
                    showToast(oldProduct.productName + " quantity is increased , Quantity = " + oldProduct.productQuantity);
                } else if (oldProduct && oldProduct.productQuantity > totalpquantity) {
                    showToast("Maximum Quantity reached, no more " + oldProduct.productName + " left");
                }
            } else {
                let product = {productId: pid, productName: pname, productQuantity: quantity, productPrice: price};
                pcart.push(product);
                localStorage.setItem("cart", JSON.stringify(pcart));
                //console.log("Product is added");
                showToast("Product is added to cart");
            }
        }
        updateCart();
    } else {
        showToast("Product Quantity can not be zero...");
    }
}

let nop=0;

//update cart:

function updateCart() {
    let cartString = localStorage.getItem("cart");
    let cart = JSON.parse(cartString);
    if (cart === null || cart.length === 0) {
        $(".cart-items").html("( 0 )");
        $(".cart-body").html("<h3>Cart does not have any items </h3>");
        $(".payment-body").html("<h3>You have not selected any items please select some items </h3>");
        $(".checkout-btn").attr('disabled', true);
        $(".order-btn").attr('disabled', true);
    } else {
//there is some in cart to show
        $(".cart-items").html(`( ${cart.length} )`);
        let table = `<table class='table'>
                        <thead class='thead-light'>
                        <tr>
                        <th>Item Name </th>
                        <th>Price </th>
                        <th>Quantity </th>
                        <th>Total Price </th>
                        <th>Action</th>
                        <th>Action</th>
                        </tr>      
                    </thead>`;
        let table1 = `<table class='table'>
                        <thead class='table-primary'>
                        <tr>
                        <th>Item Name </th>
                        <th>Price </th>
                        <th>Quantity </th>
                        <th>Total Price </th>
                        </tr>      
                    </thead>`;
        let totalPrice = 0;
        let pid = 0;
        let pq = 0;
        let a = 0;
        cart.map((item) => {

            pid = item.productId;
            pq = item.productQuantity;
            table1 += `<tr>
                         <td> ${item.productName} </td>
                         <td>&#8377;${item.productPrice} </td>
                         <td> ${item.productQuantity} </td>
                         <td>&#8377;${item.productQuantity * item.productPrice} </td>
                       </tr>`;
            table += `<tr>
                         <td> ${item.productName} </td>
                         <td>&#8377;${item.productPrice} </td>
                         <td> ${item.productQuantity} </td>
                         <td>&#8377;${item.productQuantity * item.productPrice} </td>
                         <td><button onclick='decreaseQuantity(${item.productId})' class='btn btn-warning btn-sm'>Decrease Quantity</button></td>
                         <td><button onclick='deleteItemFromCart(${item.productId})' class='btn btn-danger btn-sm'>Remove</button></td>    
                      </tr>`;
            totalPrice += item.productPrice * item.productQuantity;
            $("#pq"+a).html(pq);
            $("#pid"+a).html(pid);
            a++;
        });
        table = table + `<tr><td colspan='6' class='text-right font-weight-bold m-5' id="payment_field"> Total Price :  &#8377; ${totalPrice} </td></tr>
                    </table>`;
        table1 = table1 + `<tr><td colspan='6' class='text-right font-weight-bold m-5' id="payment_field"> Total Price :  &#8377; ${totalPrice} </td></tr>
                    </table>`;
        nop=a;
        $(".cart-body").html(table);
        $(".payment-body").html(table1);
        $("#totalprice").html(totalPrice);
        $("#nop").html(a);
        $("#pro_id").html(pid);
        $(".checkout-btn").attr('disabled', false);
    }

}

//delete item 
function deleteItemFromCart(pid)
{
    let cart = JSON.parse(localStorage.getItem('cart'));
    let newcart = cart.filter((item) => item.productId !== pid);
    localStorage.setItem('cart', JSON.stringify(newcart));
    updateCart();
    showToast("Item is removed from cart ");
}

//decrease quantity of item 
function decreaseQuantity(pid)
{
    let cart = localStorage.getItem("cart");

    //cart is already present
    let pcart = JSON.parse(cart);
    let oldProduct = pcart.find((item) => item.productId === pid);
    console.log(oldProduct);
    if (oldProduct && oldProduct.productQuantity > 1) {
        //we have to increase the quantity
        oldProduct.productQuantity = oldProduct.productQuantity - 1;
        pcart.map((item) => {
            if (item.productId === oldProduct.productId)
            {
                item.productQuantity = oldProduct.productQuantity;
            }
        });
        localStorage.setItem("cart", JSON.stringify(pcart));
        //console.log("Product quantity is increased");
        showToast("Item quantity decreased...");
    } else {
        let cart = JSON.parse(localStorage.getItem('cart'));
        let newcart = cart.filter((item) => item.productId !== pid);
        localStorage.setItem('cart', JSON.stringify(newcart));
        updateCart();
        showToast("Item is removed from cart ");
    }

    updateCart();
}

//show toast function 
function showToast(content) {
    $("#toast").addClass("display");
    $("#toast").html(content);
    setTimeout(() => {
        $("#toast").removeClass("display");
    }, 3000);
}

$(document).ready(function () {
    updateCart();
});
function goToCheckout() {
    window.location = "checkout.jsp?noOfProducts="+nop;
}

function goToIndex() {
    window.location = "index.jsp";
}

function goToAdmin() {
    window.location = "admin.jsp";
}

function goToNormal() {
    window.location = "normal.jsp";
}

$(document).ready(function () {
    $(".dropdown-toggle").dropdown();
});

//request server to create order
const paymentStart = () => {
    let cartString = localStorage.getItem("cart");
    let cart = JSON.parse(cartString);
    let totalPrice = 0;
    let email = $("#email").val();
    let name = $("#name").val();
    let phone = $("#phone").val();
    let address = $("#address").val();
    cart.map((item) => {

        totalPrice += item.productPrice * item.productQuantity;
    });
    console.log("payment started");
    let amount = totalPrice;
    console.log(amount);

    //checking order details
    if (email === null || email === "") {
        alert("Email is required...");
        return;
    }
    if (name === null || name === "") {
        alert("Name is required...");
        return;
    }
    if (phone === null || phone === "") {
        alert("Phone is required...");
        return;
    }
    if (address === null || address === "") {
        alert("Address is required...");
        return;
    }
};
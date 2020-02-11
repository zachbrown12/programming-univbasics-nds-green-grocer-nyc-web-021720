def consolidate_cart(cart)
  new_cart = {}
  #iterate through cart and convert to hash
  cart.each do |hash|
    hash.each do |name,describe|#name: AVOCADO, KALE. #describe: price, clearance
      if new_cart[name] #if the new_cart already has a name and count
        new_cart[name][:count] += 1 #increase the count by 1
      else #if cart is empty / does not contain item
        new_cart[name]=describe #set name as key and describe as value
        new_cart[name][:count] = 1 #create and set count value to 1 (first item occurance)
      end
    end
  end
  new_cart #return the new_cart 
end	end
end

def apply_coupons(cart, coupons)
  coupons.each do |coupon|
    if cart.keys.include? coupon[:item]
      if cart[coupon[:item]][:count] >= coupon[:num]
        new_name = "#{coupon[:item]} W/COUPON"
        if cart[new_name]
          cart[new_name][:count] += coupon[:num]
        else
          cart[new_name] = {
            count: coupon[:num],
            price: coupon[:cost]/coupon[:num],
            clearance: cart[coupon[:item]][:clearance]
          }
        end
        cart[coupon[:item]][:count] -= coupon[:num]
      end
    end
  end
  cart
end

def apply_clearance(cart)
  cart.keys.each do |item|
    if cart[item][:clearance]
      cart[item][:price] = (cart[item][:price]*0.80).round(2)
    end
  end
  cart
end

def checkout(cart, coupons)
  consol_cart = consolidate_cart(cart)
  cart_with_coupons_applied = apply_coupons(consol_cart, coupons)
  cart_with_discounts_applied = apply_clearance(cart_with_coupons_applied)

  total = 0.0
  cart_with_discounts_applied.keys.each do |item|
    total += cart_with_discounts_applied[item][:price]*cart_with_discounts_applied[item][:count]
  end
  total > 100.00 ? (total * 0.90).round : total
end
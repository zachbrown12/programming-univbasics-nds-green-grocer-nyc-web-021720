def find_item_by_name_in_collection(name, collection)
  counter = 0
  while counter < collection.length
   if collection[counter][:item] ==name
     return collection[counter]
    end
    counter += 1
  end
end

def consolidate_cart(cart)
  # code here
  new_cart =[]
  counter = 0
  while counter < cart.length
   new_cart_item = find_item_by_name_in_collection(cart[counter][:item], new_cart)
   if new_cart_item != nil
     new_cart_item[:count] += 1
   else
    new_cart_item = {
      :item => cart[counter][:item],
      :price => cart[counter][:price],
      :clearance => cart[counter][:clearance],
      :count => 1
    }
    new_cart << new_cart_item
  end
  counter += 1
end
new_cart
end

def apply_coupons(cart, coupons)
  # code here
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
  # code here
  cart.keys.each do |item|
    if cart[item][:clearance]
      cart[item][:price] = (cart[item][:price]* 0.8).round(2)
    end
  end
  cart
end

def checkout(cart, coupons)
  # code here
  consol_cart = consolidate_cart(cart)
  cart_with_coupons_applied = apply_coupons(consol_cart, coupons)
  cart_with_discounts_applied = apply_clearance(cart_with_coupons_applied)

  total = 0.0
  cart_with_discounts_applied.keys.each do |item|
    total += cart_with_discounts_applied[item][:price]*cart_with_discounts_applied[item][:count]
  end
  total > 100.00 ? (total * 0.90).round : total
end
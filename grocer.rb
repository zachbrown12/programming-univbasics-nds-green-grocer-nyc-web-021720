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
  counter = 0
  while counter < coupons.length
    cart_item = find_item_by_name_in_collection(coupons[counter][:item], cart)
    couponed_item_name = "#{coupons[counter][:item]} W/COUPON"
    cart_item_with_coupon = find_item_by_name_in_collection(couponed_item_name, cart)
    if cart_item && cart_item[:count] >= coupons[counter][:num]
      if cart_item_with_coupon
       cart_item_with_coupon[:count] += coupons[counter][:num]
       cart_item[:count] -= coupons[counter][:num]
      else
        cart_item_with_coupon = {
          :item => couponed_item_name
          :price => coupons[counter][:cost] / coupons[counter][:num]
          :count => coupons[counter][:num]
          :clearance => cart_item[:clearance]
        }
        cart << cart_item_with_coupon
        cart_item[:count] -= coupons[counter[:num]]
      end
    end
    counter += 1
  end
  cart
end

def apply_clearance(cart)
  counter = 0
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

def consolidate_cart(cart)
  new_cart = {}
  cart.each do |item|
    item.each do |name , value|
      if new_cart[name]
        new_cart[name][:count] += 1 
      else 
        new_cart[name] = value
        new_cart[name][:count] = 1
      end
    end
  end
new_cart
end


def apply_coupons(cart, coupons)
  coupons.each do |coupon|
    item = coupon[:item]
    coupon_item = "#{item} W/COUPON"
    if cart.has_key?(item)
      if !cart[coupon_item]  && cart[item[:count] >= coupon[:num]]
      cart[coupon_item] = {count: coupon[:num], price: coupon[:cost]/coupon[:num], cart[item][:count] -= coupon[:num]
    elsif cart[coupon_item] && cart[item][:count]  >= coupon[:num] 
        cart[coupon_item][:count] += coupon[:num]
      cart[item][:count] -= coupon[:num]
      end
    end
  end 
  cart
end

def apply_clearance(cart)
  cart.each do |product_name, stats|
    stats[:price] -= stats[:price] * 0.2 if stats[:clearance]
  end
  cart 
end

def checkout(cart, coupons)
  hash_cart = consolidate_cart(cart)
  applied_coupons = apply_coupons(hash_cart, coupons)
  applied_clearance = apply_clearance(applied_coupons)
  total = applied_clearance.reduce(0) { |acc, (key, value)| acc += value[:price] * value[:count]}
  total > 100 ? total * 0.9 : total
end

class OrdersGrid < BaseGrid

  scope do
    Order.preload(:user).order(id: :desc)
  end

  filter(:number, :integer)
  filter(:status, :enum, :select => Order.statuses.keys, dummy: true) do |value|
    where(status: value)
  end
  # filter(:created_at, :date, :range => true)

  column(:number) do |order|
    format(order.number) do |number|
      link_to number, admin_order_path(order)
    end
  end

  column(:user_email) do |order|
    order.user.email
  end

  column(:status) do |order|
    order.decorate.status
  end

  column(:created_at) do |order|
    format(order.created_at) do |value|
      order.created_at.to_s(:long)
    end
  end
end

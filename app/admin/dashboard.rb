ActiveAdmin.register_page "Dashboard" do

  menu priority: 1, label: proc{ I18n.t("active_admin.dashboard") }

  content title: "订单列表" do
  #content title: proc{ I18n.t("active_admin.dashboard") } do
    # div class: "blank_slate_container", id: "dashboard_default_message" do
    #   span class: "blank_slate" do
    #     span I18n.t("active_admin.dashboard_welcome.welcome")
    #     small I18n.t("active_admin.dashboard_welcome.call_to_action")
    #   end
    # end

    # Here is an example of a simple dashboard with columns and panels.
    #
    # columns do
    #   column do
    #     panel "Recent Posts" do
    #       ul do
    #         Post.recent(5).map do |post|
    #           li link_to(post.title, admin_post_path(post))
    #         end
    #       end
    #     end
    #   end

    #   column do
    #     panel "Info" do
    #       para "Welcome to ActiveAdmin."
    #     end
    #   end
    # end

    table title: "订单列表" do
      thead do
        tr do
          (["订单号","姓名"] + Product.pluck(:name) + ["合计", "支付方式", "提货方式"]).each &method(:th)
        end
      end
      tbody do
        Order.forprint.each do |order|
          tr do
            td do
              order.code {|order| link_to "##{order.code} ", admin_order_path(order) }
            end
            td do
              order.customer.name
            end
            Product.pluck(:id).each do |pid|
              td do
                if order.items.where(:product_id => pid).blank?
                  "-"
                else
                  order.items.where(:product_id => pid).first.amount
                end
              end
            end
            td do
              order.total
            end
            td do
              order.payment
            end
            td do
              order.delivery
            end
          end
        end
      end
    end

  end # content

  # table :download_links => [:pdf]
end

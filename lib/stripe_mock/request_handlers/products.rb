module StripeMock
  module RequestHandlers
    module Products

      def Products.included(klass)
        klass.add_handler 'post /v1/products',        :new_product
        klass.add_handler 'post /v1/products/(.*)',   :update_product
        klass.add_handler 'get /v1/products/(.*)',    :get_product
        klass.add_handler 'get /v1/products',         :list_products
        klass.add_handler 'delete /v1/products/(.*)', :delete_product
      end

      def new_product(route, method_url, params, headers)
        params[:id] ||= new_id('product')
        products[params[:id]] = Data.mock_product(params)
      end

      def update_product(route, method_url, params, headers)
        route =~ method_url
        list_item = assert_existence :list_item, $1, products[$1]
        list_item.merge!(params)
      end

      def delete_product(route, method_url, params, headers)
        route =~ method_url
        assert_existence :list_item, $1, products[$1]

        products[$1] = {
          id: products[$1][:id],
          deleted: true
        }
      end

      def list_products(route, method_url, params, headers)
        Data.mock_list_object(products.values, params)
      end

      def get_product(route, method_url, params, headers)
        route =~ method_url
        assert_existence :product, $1, products[$1]
      end

    end
  end
end

module StripeMock
  module RequestHandlers
    module Skus

      def Skus.included(klass)
        klass.add_handler 'post /v1/skus',        :new_sku
        klass.add_handler 'post /v1/skus/(.*)',   :update_sku
        klass.add_handler 'get /v1/skus/(.*)',    :get_sku
        klass.add_handler 'get /v1/skus',         :list_skus
        klass.add_handler 'delete /v1/skus/(.*)', :delete_sku
      end

      def new_sku(route, method_url, params, headers)
        params[:id] ||= new_id('sku')
        skus[params[:id]] = Data.mock_sku(params)
      end

      def update_sku(route, method_url, params, headers)
        route =~ method_url
        list_item = assert_existence :list_item, $1, skus[$1]
        list_item.merge!(params)
      end

      def delete_sku(route, method_url, params, headers)
        route =~ method_url
        assert_existence :list_item, $1, skus[$1]

        skus[$1] = {
          id: skus[$1][:id],
          deleted: true
        }
      end

      def list_skus(route, method_url, params, headers)
        Data.mock_list_object(skus.values, params)
      end

      def get_sku(route, method_url, params, headers)
        route =~ method_url
        assert_existence :sku, $1, skus[$1]
      end

    end
  end
end

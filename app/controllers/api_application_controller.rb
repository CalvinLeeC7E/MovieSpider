# 实现RESTful风格的Api创建
class ApiApplicationController < ApplicationController
  class << self
    def define_api(api_name, api_method='GET', api_version='v1', &block)
      final_api_name = "#{api_method.upcase}-#{api_name}-#{api_version}"
      define_method final_api_name, block
    end

    # 支持如下方法
    ['get', 'post', 'put', 'patch', 'delete'].each do |request_method|
      define_method "api_#{request_method}" do |api_name, api_version='v1', &block|
        define_api(api_name, request_method.upcase, api_version, &block)
      end
    end
  end

  def call_api
    api_name = params[:api_name]
    api_version = params[:api_version]
    render json: invoke_api(api_name, api_version)
  end

  def invoke_api(api_name, api_version='v1')
    final_api_name = "#{request.method}-#{api_name}-#{api_version}"
    return {error: 'api not found'} unless respond_to? final_api_name
    send final_api_name
  end
end
module ApplicationHelper
  def table_list(record, options={})
    options = ActiveSupport::HashWithIndifferentAccess.new options
    attributes = record.attribute_names
    attributes = attributes - ['updated_at', 'created_at']
    attributes = options.fetch(:only, []) if options.has_key? :only
    attributes = attributes - options.fetch(:except, []) if options.has_key? :except
    custom_attr = options.fetch(:custom_attr, {})
    erb = ERB.new %q{
<table class="table table-bordered">
  <% record.each do |item| %>
    <tr>
      <% attributes.each do |attr| %>
        <td>
          <% if custom_attr.has_key? attr %>
            <%= custom_attr[attr].call(item[attr]) %>
          <% else %>
             <%= item[attr] %>
          <% end %>
        </td>
      <% end %>
    </tr>
  <% end %>
</table>
}
    erb.result(binding).html_safe
  end
end

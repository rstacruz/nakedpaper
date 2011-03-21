# This is a mixin, not a class.
NN.LineFeedView =
  classname: 'line'

  template:
    _.template """
    <% _.each(entries, function(entry) { %>
      <% e = entry.attributes; %>
      <article>
        <a href="<%= e.href %>">
          <span class="date">
            <%= e.published.toLocaleString() %>
          </span>
          <% if (e.image) { %>
            <span class="image" style="background-image:
              url(<%= e.image %>);"></span>
          <% } %>
          <strong>
            <%= e.title %>
          </strong>
          <div class="summary">
            <%= e.summary %>
          </div>
        </a>
      </article>
    <% }); %>
    """


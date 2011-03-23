# This is a mixin, not a class.
NN.CompactFeedView =
  classname: 'compact'

  templates:
    first:
      _.template """
      <% _.each(entries, function(entry) { %>
        <% e = entry.attributes; %>
        <article>
          <a href="<%= e.href %>">
            <% if (e.image) { %>
              <span class="image" href="<%= e.href %>" style="background-image: 
              url(<%= e.image %>);"></span>
            <% } %>

            <h2><%= e.title %></h2>

            <div class="summary"><%= e.summary %></div>
          </a>
        </article>
      <% }); %>
      """

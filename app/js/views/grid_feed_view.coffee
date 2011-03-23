# This is a mixin, not a class.
NN.GridFeedView =
  classname: 'grid'

  templates:
    first:
      _.template """
      <% _.each(entries, function(entry) { %>
        <% e = entry.attributes; %>
        <% if (e.image) { %>
          <article class="image" style="background-image: url(<%= e.image %>);">
        <% } else { %>
          <article>
        <% } %>
          <a href="<%= e.href %>">
            <h2><%= e.title %></h2>
            <div class="summary"><%= e.summary %></div>
          </a>
        </article>
      <% }); %>
      """

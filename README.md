# Halumi

## Example usage

### Define your query classes

```Ruby
class ArticlesQuery < Halumi::Query
  model Article

  merge PaginationQuery
  merge PublishedArticlesQuery
  merge OrderArticlesQuery
end
```

```Ruby
class PaginationQuery < Halumi::Query
  param :per_page
  param :page

  def call
    relation.page(page).per(per_page)
  end
end
```
```Ruby
class PublishedArticlesQuery
  relation.where(published: true)
end
```

```Ruby
class OrderArticlesQuery < Halumi::Query
  def call
    relation.order(:created_at)
  end
end

```

### Run your query

```Ruby

  params = { page: 2, per_page: 10 }

	ArticlesQuery.new(params).call
```

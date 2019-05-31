# Halumi
![Gem](https://img.shields.io/gem/v/halumi.svg) ![GitHub](https://img.shields.io/github/license/PiotrWald/halumi.svg)

One of the patterns in Rails development I find usefull are query objects.
They are essantialy service objects returning a ActiveRecord Relation. Using them
results in less code cluttering your controllers and models. Plus you can easily
unit test each of your queries.

This Gem adds simple DSL allowing you to build query objects and than merge
them into one query (ActiveRecord::Relation)

One of the cool patterns in Rails development are query objects.
They are essantialy service objects returning a ActiveRecord Relation. Using them
results in less code cluttering your controllers and models. Plus you can easily
unit test each of your queries.

This Gem adds simple DSL allowing you to build query objects and than combining
them into one query that will be executed against your database

## Example usage

### Define your 'super' query combining 3 subqueries

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

  def execute
    relation.page(page).per(per_page)
  end
end
```
```Ruby
class PublishedArticlesQuery
  def execute
    relation.where(published: true)
  end
end
```

```Ruby
class OrderArticlesQuery < Halumi::Query
  def execute
    relation.order(:created_at)
  end
end

```

### Run your query

This will return published articles, paginated and sorted by creation time

```Ruby

  params = { page: 2, per_page: 10 }

	ArticlesQuery.new(params).call
```

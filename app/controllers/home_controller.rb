# Renders the home page.
class HomeController < ApplicationController
  def index
  end

  def team
    @breadcrumbs.push(team_breadcrumb)
  end

  def rick
    @breadcrumbs.push(team_breadcrumb)
    @breadcrumbs.push(rick_breadcrumb)
  end

  def drew
    @breadcrumbs.push(team_breadcrumb)
    @breadcrumbs.push(drew_breadcrumb)
  end

  def craig
    @breadcrumbs.push(team_breadcrumb)
    @breadcrumbs.push(craig_breadcrumb)
  end
end

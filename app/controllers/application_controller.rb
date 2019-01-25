class ApplicationController < ActionController::Base
  before_action :set_breadcrumb

  def set_breadcrumb
    @breadcrumbs = [home_breadcrumb]
  end

  def home_breadcrumb
    { label: 'Home', path: '/', options: { active_when: { controller: 'home', action: 'index' } } }
  end

  def team_breadcrumb
    { label: 'Team', path: '/team', options: { active_when: { controller: 'home', action: 'team' } } }
  end

  def rick_breadcrumb
    {
      label: 'Rick',
      path: '/team/rick',
      options: {
        active_when: {
          controller: 'home',
          action: 'rick'
        }
      }
    }
  end

  def craig_breadcrumb
    {
      label: 'Craig',
      path: '/team/craig',
      options: {
        active_when: {
          controller: 'home',
          action: 'craig'
        }
      }
    }
  end

  def drew_breadcrumb
    {
      label: 'Drew',
      path: '/team/drew',
      options: {
        active_when: {
          controller: 'home',
          action: 'drew'
        }
      }
    }
  end

  def question_breadcrumb
    {
      label: 'Ask a Question',
      path: '/questions/new',
      options: {
        active_when: {
          controller: 'questions',
          action: 'new'
        }
      }
    }
  end
end

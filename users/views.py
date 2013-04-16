from django.contrib.auth.views import login as auth_login


def login(request, **kwargs):
    import ipdb; ipdb.set_trace()
    return auth_login(request, template_name='users/login.html')

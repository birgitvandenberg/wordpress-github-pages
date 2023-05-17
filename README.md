# wordpress-github-pages

Template to deploy a Simply Static Wordpress export to GitHub Pages.

Prerequisites:
- Download a Simply Static export zip file from your Wordpress dashboard
and put it in the `import` directory in this repository.
On Linux you can also leave it in your `Downloads` folder in your home directory
to automatically copy it with the `import` make target.
- Optionally create a `CNAME` file in the `copy` directory
that contains the domain name of your website.
This would be created by GitHub automatically when you configure your site's domain
but we have to copy it on each site build, so it's better to define it here.
- Optionally create any other static files in the `copy` directory
that should be copied to the web root of the site.
- If you care about your sitemap, change the variables at the top of the `Makefile` accordingly,
in case the url of the sitemap.xml is not properly configured in the robots.txt file of the Simply Static export.

Run `make` to build, commit and deploy (push) the website.

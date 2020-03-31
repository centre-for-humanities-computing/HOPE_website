# Hope project website

hosted files are transpiled into /docs
website is hosted at https://hope-project.dk

to run the website off of github pages change the following setting in `./vue.config.js`:

```
  publicPath: process.env.NODE_ENV === 'production' ? '/HOPE_website/' : '/' // account for the repo name offset with github Pages
```

as opposed to 

```
  publicPath: '/' // local server. no offset
```

end-user editable content is in the [HOPE_website_content repository](https://github.com/centre-for-humanities-computing/HOPE_website_content)

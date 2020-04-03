import axios from "axios"

export default {
  props: {
    filePath: {
      type: String,
      required: true
    }
  },
  data () {
    return {
      repoUrl: 'https://raw.githubusercontent.com/centre-for-humanities-computing/HOPE_website_content/master'
    }
  },
  computed: {
    fileName() {
      const parts = this.filePath.split('/')
      const filename = parts[parts.length -1].split('.')[0]
      return filename
    }
  },
  asyncComputed: {
    file() {
      let repoUrl = this.repoUrl
      if (repoUrl.lastIndexOf('/') < repoUrl.length - 1) {
        repoUrl += '/'
      }
      return axios
        .get(`${repoUrl}${this.filePath}`)
        .then(response => {
          return response.data
        })
        .catch(error => {
          if (this.hideTillLoaded) {
            console.log(error)
          } else {
            let message
            if (error.message === 'Request failed with status code 404') {
              message = `\nArticle not found.`
            } else {
              message = '\n' + error
            }
            let messageHTML = `
  <div class="error">
    <div class="address"></div>
      <span class="method">GET</span>
      <span class="url">${repoUrl}${this.filePath}</span>
    </div>
    <div class="message">
      ${message}
    </div>
  `
            return messageHTML
          }
        })
    }
  }
}

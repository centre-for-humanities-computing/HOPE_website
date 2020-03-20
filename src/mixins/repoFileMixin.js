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
  asyncComputed: {
    file() {
      let repoUrl = this.repoUrl
      if (repoUrl.lastIndexOf('/') < repoUrl.length - 1) {
        repoUrl += '/'
      }
      return axios
        .get(`${repoUrl}${this.filePath}`)
        .then(response => response.data)
        .catch(error => {
          let message = `GET ${repoUrl}${this.filePath}\n`
          if (error.message === 'Request failed with status code 404') {
            message += `Article not found.`
          } else {
            message += '\n' + error
          }
          return message
        })
    }
  }
}

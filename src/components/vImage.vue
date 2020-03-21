<template>
  <div class="image">
    <img
      :src="src"
      :alt="alt"
    >
  </div>
</template>

<script>
  import {mapState} from 'vuex'
  import { SET_SCENE_HEIGHT_IS_DIRTY } from "../modules/box/types"
  export default {
    name: "vImage",
    props: {
      src: {
        type: String,
        required: true
      },
      alt: {
        type: String,
        default: ''
      },
      isOdd: {
        type: Boolean,
        default: false
      }
    },
    data() {
      return {
        /*
          non-panorama images are limited to this proportion of the available width for their shorter side
         */
        maxImageProportion: 0.4,
      }
    },
    mounted() {
      this.$nextTick(() => {
        window.addEventListener('resize', () => {
          this.styleImage()
        })
      })

      const img = this.$el.querySelector('img')
      img.onload = this.onImageLoaded

    },
    methods: {
      onImageLoaded() {
        requestAnimationFrame(this.styleImage)
      },
      styleImage() {
        const img = this.$el.querySelector('img')
        const isPortrait = img.clientHeight > img.clientWidth

        if (isPortrait) {

          img.style.maxWidth = `${this.maxImageProportion * 100}%`

        } else {


          const columnWidth = img.parentElement.offsetWidth
          const isPanorama = img.clientWidth >= 2 * img.clientHeight
          const imageCanCoverColumn = img.clientWidth >= 0.9 * columnWidth
          const fitToColumn = isPanorama && imageCanCoverColumn
          if (fitToColumn) {
            img.style.height = '100%'
          } else {
            img.style.maxHeight = `${this.maxImageProportion * 100}vh`
          }

          img.style.width = 'auto'

          //img.height = 'auto'
          const textIsSquashed = img.clientWidth / columnWidth >= 0.75
          if (textIsSquashed) {
            img.style.height = 'initial'
            img.style.width = '100%'
          }

        }
        img.style.float = this.isOdd ? 'left' : 'right'
        img.style[`margin${this.isOdd ? 'Right' : 'Left'}`] = '1em'
        img.style.marginTop = '.5em'
      }
    }
  }
</script>

<style scoped>
  img {
    clear: both;
    max-width: 100%;
  }
</style>

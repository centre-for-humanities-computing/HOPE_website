<template>
  <div class="boxRouter">
    <div
      class="scene"
      :style="sceneStyle"
    >
      <div
        class="box"
        :style="boxStyle"
      >
        <side face="front" />
        <side face="back" />
        <side face="right" />
        <side face="left" />
        <side face="top" />
        <side face="bottom" />
      </div>
    </div>
  </div>
</template>

<script>
  import {
    SET_SCENE_WIDTH,
    SET_SCENE_HEIGHT,
    SET_BOX_WIDTH,
    SET_BOX_DEPTH,
    SET_SCENE_HEIGHT_IS_DIRTY,
    SET_BOX_HEIGHT
  } from '../../modules/box/types'
import Side from './Side'

const namespace = 'box'
export default {
  name: 'Box',
  components: {
    Side,
  },
  data() {
    return {
      resizeCooldownTimer: null
    }
  },
  computed: {
    sceneHeight() {
      return this.$store.state.box.sceneHeight
    },
    sceneWidth() {
      return this.$store.state.box.sceneWidth
    },
    face: {
      get() {
        return this.$store.state.box.face
      }
    },
    perspective() {
      return this.sceneWidth * 4
    },
    sceneStyle() {
      let style = {}
      style.height = `${this.sceneHeight}px`
      style.perspective = `${this.perspective}px`
      return style
    },
    boxStyle() {
      let style = {}
      style.height = `${this.height}px`
      style.width = `${this.sceneWidth}px`
      style.transform = `${this.yTranslation(this.face)} ${this.zTranslation(this.face)} ${this.yRotation(this.face)}`
      style.transition = `transform ${this.transitionTime}s ease`
      if (this.debug) {
        style.backgroundColor = `#000;`
      }
      return style
    },
    width() {
      return this.$store.state.box.width
    },
    height() {
      return this.$store.state.box.height
    },
    depth() {
      return this.$store.state.box.depth
    },
    transitionTime() {
      return this.$store.state.box.transitionTime
    },
    debug() {
      return this.$store.state.box.debug
    }
  },
  watch: {
    $route() { // to, from
      () => this.invalidateSceneDimensions('route changed A')
    }
  },
  mounted() {
    this.$nextTick(() => {
      window.addEventListener('resize', () => this.invalidateSceneDimensions('window resized'))
    })
    this.$watch(
      '$route',
      () => this.invalidateSceneDimensions('route changed B')
    )
    this.$watch(
      `$store.state.${namespace}.sceneHeightIsDirty`,
      (newVal, oldVal) => {
        const isDirty = newVal && !oldVal
        if (isDirty) {
          this.invalidateSceneDimensions('scene dimensions are dirty')
        }
      }
    )
  },
  updated() {
    this.invalidateSceneDimensions('route changed B')
  },
  methods: {
    yTranslation(face) {
      // compensates for turning tall and slim box onto its side
      let translation = ''
      if (['top', 'bottom'].indexOf(face) !== -1) {
        translation = `translateY(${-(this.height - this.depth) / 2}px)`
      }
      return translation
    },
    zTranslation(face) {
      // maintains center of box in center of scene (coupled with yRotation)
      let translation = ''
      if (['front', 'back'].indexOf(face) !== -1) {
        translation = `translateZ(${-this.depth / 2}px)`
      } else if (['right', 'left'].indexOf(face) !== -1) {
        translation = `translateZ(${-this.width / 2}px)`
      } else if (['top', 'bottom'].indexOf(face) !== -1) {
        translation = `translateZ(${-this.height / 2}px)`
      }
      return translation
    },
    yRotation(face) {
      // rotates active box side to face the window
      let rotation = 0
      if (face === 'front') rotation = `rotateY(0deg)`
      if (face === 'back') rotation = `rotateY(-180deg)`
      if (face === 'right') rotation = `rotateY(-90deg)`
      if (face === 'left') rotation = `rotateY(90deg)`
      if (face === 'top') rotation = `rotateX(-90deg)`
      if (face === 'bottom') rotation = `rotateX(90deg)`
      return rotation
    },
    adjustSize() {
      this.$store.commit(namespace + '/' + SET_SCENE_WIDTH, Math.min(this.$el.clientWidth, window.innerWidth))
      this.$store.commit(namespace + '/' + SET_BOX_WIDTH, Math.min(this.$el.clientWidth, window.innerWidth))
      this.$store.commit(namespace + '/' + SET_BOX_DEPTH, Math.min(this.$el.clientWidth, window.innerWidth))

      const activeSide = this.$el.children[0].querySelector(`.side.active`)

      if (activeSide) {
        //console.log(`resizing scene due to: ${this.$store.state.box.sceneHeightIsDirty}`)

        const frameHeight = this.getContentHeight()

        this.$store.commit(namespace + '/' + SET_SCENE_HEIGHT, frameHeight)

        this.lastSceneHeight = frameHeight

      }

      this.$store.commit(namespace + '/' + SET_SCENE_HEIGHT_IS_DIRTY, false)
    },
    getActiveDimension(sideEl) {
      let dimension = 'height'
      let faceName = sideEl.className.filter(n => n.indexOf(['top', 'bottom', 'left', 'right', 'front', 'back']) >= 0)
      if (['top', 'bottom'].indexOf(faceName) >= 0) dimension = 'depth'
      return dimension
    },
    getContentHeight() {
      const activeSide = this.$el.children[0].querySelector(`.side.active`)

      let content
      for (var i = 0; i < activeSide.childNodes.length; i++) {
        if (activeSide.childNodes[i].nodeType === 1) {
          break
        }
      }

      if (i < activeSide.childNodes.length) {
        content = activeSide.childNodes[i]
      }

      let height = activeSide.clientHeight
      if (content) height = content.clientHeight

      height += activeSide.offsetTop

      if (activeSide) {
        const ss = window.getComputedStyle(activeSide)

        height += parseInt(ss.getPropertyValue('padding-top')) || 0
        height += parseInt(ss.getPropertyValue('padding-bottom')) || 0
        height += parseInt(ss.getPropertyValue('margin-top')) || 0
        height += parseInt(ss.getPropertyValue('margin-bottom')) || 0
        height += parseInt(ss.getPropertyValue('border-width')) || 0

        if (content) {

          height += content.offsetTop

          const cs = window.getComputedStyle(content)

          height += parseInt(cs.getPropertyValue('padding-top')) || 0
          height += parseInt(cs.getPropertyValue('top')) || 0
          height += parseInt(cs.getPropertyValue('padding-bottom')) || 0
          height += parseInt(cs.getPropertyValue('margin-top')) || 0
          height += parseInt(cs.getPropertyValue('margin-bottom')) || 0
          height += parseInt(cs.getPropertyValue('border-width')) || 0

        }

      }

      return height * 1.02 // allow for side being "elevated towards the camera"
    },
    invalidateSceneDimensions(triggerAlias) {
      this.$nextTick(() => {
        this.$store.commit(`${namespace}/${SET_SCENE_HEIGHT_IS_DIRTY}`, triggerAlias)
        this.adjustSize()
      })
    }
  }
}
</script>

<style scoped>
  .scene {
    width: 96vm;
  }
  .box {
    position: relative;
    transform-style: preserve-3d;
  }
</style>

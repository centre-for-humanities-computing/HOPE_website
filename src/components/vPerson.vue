<template>
  <div class="person card">
      <div class="frame">
        <div
          class="portrait"
          :style="portraitStyle" :title="`image of ${person.name}`"></div>
      </div>
      <div class="details">
        <div class="title">{{person.title}}<span v-if="person.role">, {{person.role}}</span></div>
        <div class="name">{{person.name}}</div>
        <div class="contactDetails">
          <em class="affiliation">
            {{person.affiliation}}
          </em>
          <hr>
          <div class="email">
            <span>{{person.email}}</span>
          </div>
          <div v-if="person.phone">

          <div
            v-if="Array.isArray(person.phone)"
            class="phone">
            <div
              v-for="number in person.phone"
              :key="number"
              class="number">
              {{number}}</div>
            </div>
            <div
              v-else
              class="number">
              {{person.phone}}
            </div>
            </div>
          <div
            v-if="person.building && person.room"
            class="location">
            <a class="building" target="_blank" :href="`https://international.au.dk/about/contact/?b=${person.building}`">
              office:
              <span>{{person.building}}</span>,
              <span>{{person.room}}</span>
            </a>
          </div>
        </div>
      </div>
  </div>
</template>

<script>
  export default {
    name: "vPerson",
    props: {
      person: {
        type: Object,
        required: true
      }
    },
    computed: {
      portraitStyle() {
        return {
          backgroundImage: `url(${this.person.imageUrl || 'https://upload.wikimedia.org/wikipedia/commons/9/9a/No_avatar.png'})`,
          backgroundPosition: `${this.person.imagePosX || 'center'} ${this.person.imagePosY || 'center'}`
        }
      }
    },
  }
</script>

<style scoped>
  .person {
    text-align: left;
    background-color: transparent;
    border-radius: .2em;
    display: grid;
    grid-template-columns: auto auto;
    padding: 1em;
  }
  .frame {
    border: 1px solid rgba(0,0,0,0.2);
    border-radius: 4px;
    padding: .5em;
  }
  .portrait {
    background-repeat: no-repeat;
    background-size: cover;
    width: 150px;
    height: 100%;
  }
  .details {
    margin-left: 1em;
  }
  .location {
    margin-top: .5em;
    cursor: pointer;
  }
</style>

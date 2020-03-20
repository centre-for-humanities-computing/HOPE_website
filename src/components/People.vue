<template>
  <div class="people">
    <h1>People</h1>
    <div
      v-for="(person, index) in people"
      :key="index"
      class="person card"
    >
      <div class="body">
        <img :src="person.imageUrl" :alt="`image of ${person.name}`">
        <div class="details">
          <div class="title">{{person.title}}</div>
          <div class="name">{{person.name}}</div>
          <div class="contactDetails">
            <div class="affiliation">
              {{person.affiliation}}
            </div>
            <div
              v-if="person.building && person.room"
              class="location">
              <div class="building" @click="$router.push(`https://international.au.dk/about/contact/?b=${person.room}`)"></div>
              <div class="room">{{person.room}}</div>
            </div>
            <div class="email">{{person.email}}</div>
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
              class="number">{{person.phone}}</div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import people from '../../content/people.json'
export default {
  name: 'People',
  data() {
    return {
      people
    }
  }
}
</script>

<style scoped>
  .body {
    display: grid;
    grid-template-columns: 180px auto;
  }
  img {
    border: 1px solid #ddd;
    border-radius: 4px;
    padding: 5px;
    width: 150px;
  }
</style>

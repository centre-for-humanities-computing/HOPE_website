<template>
  <div class="home">
    <v-container>
      <v-layout
        align-center
      >
        <v-flex xs12>
          <v-card>
            <v-card-title>
              <div class="heading">
                <h1>HOPE</h1>
              </div>
            </v-card-title>
            <v-card-text>
              <h2 class="subtitle">How Democracies Cope with Covid19 - A Data-Driven Approach</h2>
              <br>
              <p>
                How do democracies react and cope as the covid19 crisis unfolds and with what effects? This is the core question we ask in the HOPE project - “How Democracies Cope with Covid19: A Data-Driven Approach”. The HOPE project constitutes an unprecedented research project which examines the interrelationship between the (a) trajectory of the covid19, (b) the decisions of governments and international organisations, (c) media and social media landscapes and (d) citizens’ behavior and well-being. To this end, we utilize the fact that the covid19 pandemic is unfolding in the middle of the “big data” revolution. For the first time in human history, we are able to measure with extreme precision and time-resolution how governments and citizens react (and with what consequences) during an extremely severe crisis.
              </p>
              <p>
                The HOPE project involves two phases. The first phase occurs during the unfolding of the covid19 and focuses all resources on data-harvesting and rapid analyses to support key national authorities in their efforts to contain the covid19 epidemic. In Denmark, for example, we are currently seeking to establish contact with the prime minister’s office and the ministry of health and will seek to help qualify their decisions for the benefit of society. Achieving the highest level of social scientific responsibility is crucial in this phase.
              </p>
              <p>
                The second phase occurs after the covid19 crisis and focuses on understanding and evaluating how the different strategies and events shaped the trajectory of the epidemic across different countries.
              </p>
              <p>
                Please edit the .md files in course
              </p>
              <md :source="md.source"></md>
            </v-card-text>
          </v-card>
        </v-flex>
      </v-layout>
    </v-container>
  </div>
</template>

<script>
  import Md from './Md'
  import homeMD from '../../content/home.md'
  export default {
    name: 'Home',
    components: {
      Md
    },
    data() {
      return {
        md: '# homeMD.source'
      }
    },
    created() {
      console.log(homeMD)

    }
  }
</script>
<style scoped>
  .heading {
    display: inline;
  }

</style>

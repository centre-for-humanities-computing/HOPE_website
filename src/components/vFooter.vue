<template>
  <footer>


    <div id="c172796" class="csc-default"><footer class="row global">
      <div class="large-6 medium-6 columns small-12">
        <div class="row">
          <div class="small-6 large-3 medium-6 columns">
            <h3>Institut for Statskundskab</h3>
            <p>Aarhus BSS<br>
               Aarhus Universitet<br>
               Bartholins Allé 7<br>
               8000 Aarhus C
            </p>
          </div>
          <div class="small-6 large-3 medium-6 columns">
            <h3>Kontakt</h3>
            <p>E-mail: <a href="mailto:statskundskab@au.dk" target="_blank">statskundskab@au.dk</a><br>
               Tlf: 8715 0000<br>
               Fax: 8613 9839</p>

          </div>
          <div class="small-12 large-3 medium-6 columns">
            <h3>CVR</h3>
            <p>CVR-nr: 31119103<br>
               P-nummer: 1013137702<br>
               EAN-nr: 5798000419582<br>
               Stedkode: 5311</p>


          </div>
          <div class="small-12 large-3 medium-6 columns">
            <!--h3>Akkrediteringer</h3>

            <p>

              <a href="https://datadirect.aacsb.edu/public/profiles/profile.cfm?interstitialComplete=1&amp;runReport=1&amp;unitid=55087&amp;userType=All"> <img src="https://auinstallation28.cs.au.dk/fileadmin/BSS/Grafik/akkrediteringslogoer/aacsb_logo_trans_white_small.png" alt="AACSB-logo med henvisning til organisationens hjemmeside"></a><br><br>

              <a href="https://www.associationofmbas.com/"> <img src="https://auinstallation28.cs.au.dk/fileadmin/BSS/Grafik/akkrediteringslogoer/AMBA_logo_trans_white_small.png" alt="AMBA-logo med henvisning til organisationens hjemmeside"></a><br><br>

              <a href="https://www.efmd.org"> <img src="https://auinstallation28.cs.au.dk/fileadmin/BSS/Grafik/akkrediteringslogoer/equis_trans_white_small.png" alt="EQUIS-logo med henvisning til organisationens hjemmeside"></a>

            </p-->


            <p class="muted">
              <br><br>
              <a href="https://www.au.dk/om/profil/detteweb/ophavsret/" style="text-decoration: none">©</a> —
              <a href="https://www.au.dk/om/profil/cookies/">Cookies på au.dk</a><br>
              <a href="https://www.au.dk/om/profil/privatlivspolitik/">Privatlivspolitik</a>
            </p>

          </div>
        </div>
      </div>

    </footer><div id="au_cookiesalert" style="display: none;"><h1>Hvis du klikker videre på siden, <strong>accepterer du vores brug af cookies</strong>.</h1><p>Aarhus Universitet bruger cookies til at udarbejde statistik og i forbindelse med annoncering og services fra sociale medier, som vi benytter. <span class="hide-for-small-only">Klikker du videre på siden, accepterer du, at der sættes cookies til disse formål. <a href="https://www.au.dk/om/profil/cookies/">Læs mere om cookies på au.dk, herunder hvordan du fravælger brugen af cookies</a>.</span><span class="show-for-small-only"><a href="https://www.au.dk/om/profil/cookies/">Læs mere</a>.</span></p><p class="button" id="au_cookiesalert_yes"><button>Acceptér og luk</button></p></div></div>
  </footer>
</template>

<script>
  export default {
    name: "vFooter"
  }
</script>

<style scoped>
  @font-face {
    font-family: AUPassataBold;
    src: url(https://www.aucdn.dk/fonts/aupassata_bold-webfont.woff2);
  }
  footer {
    padding: 0;
    margin: 0;
    font-family: Georgia;
    font-weight: 100;
    line-height: 1.5;
    font-size: 1.1rem;
    color: white;
    -webkit-font-smoothing: antialiased;
  }
  footer * {
    box-sizing: inherit;
    text-rendering: optimizeLegibility;
  }
  blockquote, dd, div, dl, dt, form, h1, h2, h3, h4, h5, h6, li, ol, p, pre, td, th, ul {
    margin: 0;
    padding: 0;
  }
  .row {
    max-width: 127.27273rem;
    margin-right: auto;
    margin-left: auto;
    display: -ms-flexbox;
    display: flex;
    -ms-flex-flow: row wrap;
    flex-flow: row wrap;
  }
  .columns {
    background-color: #002546;
    color: #fff;
    padding-top: 2em;
    padding-bottom: 2em;
  }
  h3 {
    font-size: 110%;
    font-family: AUPassataBold;
    margin-bottom: 2rem;
    text-transform: uppercase;
    line-height: 1.4;
    margin-top: 0;
    font-style: normal;
    font-weight: 400;
    color: inherit;
    display: block;
    margin-block-start: 1rem;
    margin-block-end: 1rem;
    margin-inline-start: 0px;
    margin-inline-end: 0px;
  }
  .muted {
    margin-bottom: 1rem;
    font-size: inherit;
    line-height: 1.6;
    color: #687989;
    padding-top: 2em;
    padding-bottom: 2em;
  }
  @media print, screen and (min-width: 64em) {

    .large-6 {
      -ms-flex: 0 0 50%;
      flex: 0 0 50%;
      max-width: 50%;
    }
  }
  @media print, screen and (min-width: 40em) {

    .medium-6 {
      -ms-flex: 0 0 50%;
      flex: 0 0 50%;
      max-width: 50%;
    }
    .small-12 {
      -ms-flex: 0 0 100%;
      flex: 0 0 100%;
      max-width: 100%;
    }
  }
  @media print, screen and (min-width: 40em) {
    .column, .columns {
      padding-right: 1.36364rem;
      padding-left: 1.36364rem;
    }
    .column, .columns {
      -ms-flex: 1 1 0px;
      flex: 1 1 0px;
      padding-right: .90909rem;
      padding-left: .90909rem;
      min-width: 0;
    }
    *, :after, :before {
      box-sizing: inherit;
    }
    div {
      display: block;
    }
  }
</style>

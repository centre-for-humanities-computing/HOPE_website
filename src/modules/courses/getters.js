import reservedWords from "../../lib/reservedWords"

export const DEFAULT_VERTICE = 'DEFAULT_VERTICE'
export const VERTICE_ATTRIBUTE_RULES = 'VERTICE_ATTRIBUTE_RULES'

function generateVertex(timestamp) {
  return {
    id: `unsaved_vertex_${timestamp}`,
    displayName: 'My New Vertex',
    description: 'This vertex serves to fulfill a purpose',
    variableName: 'my_new_vertex', // auto-generated
    episodes: []
  }
}

export default {
  [DEFAULT_VERTICE]: () => timestamp => generateVertex(timestamp),
  [VERTICE_ATTRIBUTE_RULES]: () => {
    return {
      displayName: [
        v => !!v || 'Provide a label to be used in User Interfaces'
      ],
      description: [
        v => !!v || 'Describe this vertex to your users and your future self'
      ],
      variableName: [
        v => !!v || 'Provide a variable title to represent this vertex in code',
        v => (v && !v.match(/^\d/)) || 'Variable title must not begin with a number',
        v => (v && v.match(/^[\w$]+$/)) !== null || 'Variable title can only contain the letters a-z, A-Z, 0-9, and _ or $', // todo: revisit upon ES9 release with RegExp unicode block shorthands.. \p{L}
        v => (v && [...reservedWords].indexOf(v) < 0) || `${v} is reserved and cannot be used`
      ]
    }
  }
}

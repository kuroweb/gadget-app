<template>
  <v-dialog
    v-model="dialogStatus"
    max-width="400px"
    persistent
  >
    <v-card width="500px" class="mx-auto">
    <v-toolbar flat>
      <v-toolbar-title>コメントに返信する</v-toolbar-title>
      <v-spacer></v-spacer>
      <v-btn 
        @click="closeDialog"
        icon
      >
        <v-icon>mdi-close</v-icon>
      </v-btn>
    </v-toolbar>
      <v-card-text>
        <v-form>
          <ValidationObserver v-slot="ObserverProps">
            <TextFieldWithValidation
              v-model="description"
              label="返信内容"
              rules="max:255|required"
            />
            <v-row justify="center">
              <v-btn
                color="success"
                class="white--text"
                @click="createComment"
                :disabled="ObserverProps.invalid"
              >送信
              </v-btn>
            </v-row>
          </ValidationObserver>
        </v-form>
      </v-card-text>
    </v-card>
  </v-dialog>
</template>
<script>
import TextFieldWithValidation from '~/components/molecules/inputs/TextFieldWithValidation.vue'
export default {
  components: {
    TextFieldWithValidation,
  },
  props: {
    dialog: {
      type: Boolean,
      required: true
    },
    boardId: {
      type: null,
    },
    parentComment: {
      type: null
    }
  },
  data () {
    return {
      dialogStatus: this.dialog,
      description: ''
    }
  },
  watch: {
    dialog (newValue) {
      this.dialogStatus = newValue
    },
  },
  computed: {
  },
  methods: {
    async createComment () {
      this.$axios.$post(process.env.BROWSER_BASE_URL + '/v1/board_comments', {
        user_id: this.$store.state.modules.user.data.id,
        board_id: this.boardId,
        description: this.description,
        reply_comment_id: this.parentComment.id
      })
    },
    closeDialog () {
      this.$emit('closeDialog')
    },
  }
}
</script>
<style>
</style>
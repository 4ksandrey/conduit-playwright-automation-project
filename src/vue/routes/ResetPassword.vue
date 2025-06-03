<template>
  <div class="auth-page">
    <div class="container page">
      <div class="row">
        <div class="col-md-6 offset-md-3 col-xs-12">
          <h1 class="text-xs-center">Reset Password</h1>
          <p class="text-xs-center mt-3">
            <router-link :to="{ name: 'login' }">Back to login</router-link>
          </p>
          <ul v-if="errors" class="error-messages">
            <li v-for="(v, k) in errors" :key="k">{{ k }} {{ v | error }}</li>
          </ul>

          <form @submit.prevent="submit">
            <fieldset class="form-group">
              <input
                class="form-control form-control-lg"
                type="email"
                v-model="email"
                placeholder="Email"
                required
              />
            </fieldset>
            <fieldset class="form-group">
              <input
                class="form-control form-control-lg"
                type="password"
                v-model="password"
                placeholder="New Password"
                required
              />
            </fieldset>
            <fieldset class="form-group">
              <input
                class="form-control form-control-lg"
                type="password"
                v-model="confirmPassword"
                placeholder="Confirm New Password"
                required
              />
            </fieldset>
            <button class="btn btn-lg btn-primary pull-xs-right">
              Reset Password
            </button>
            <div v-if="localError" class="error-messages">
              <li>{{ localError }}</li>
            </div>
          </form>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import swal from "sweetalert";
import { mapGetters } from "vuex";

export default {
  name: "ResetPassword",
  data() {
    return {
      email: "",
      password: "",
      confirmPassword: "",
      localError: ""
    };
  },
  computed: {
    ...mapGetters(["errors"])
  },
  methods: {
    async submit() {
      if (this.password !== this.confirmPassword) {
        this.localError = "Passwords do not match.";
        return;
      }

      this.localError = "";

      swal({
        text: "Resetting your password... Please wait...",
        buttons: false,
      });

      const response = await this.$store.dispatch("resetPassword", {
        email: this.email,
        password: this.password
      });

      if (response === true) {
        swal({
          title: "Success!",
          text: "Password successfully reset!",
          icon: "success"
        }).then(() => {
          if (this.$route.name !== "login") {
            this.$router.push({ name: "login" }).catch((err) => {
              if (err.name !== "NavigationDuplicated") throw err;
            });
          }
        });
      } else {
        let errorText = "Something went wrong.";
        if (response.errors && response.errors.body) {
          errorText = response.errors.body.join(" ");
        }
        swal({
          title: "Reset failed!",
          text: errorText,
          icon: "error"
        });
      }
    }
  },
  beforeRouteEnter(to, from, next) {
    next((vm) => {
      vm.email = "";
      vm.password = "";
      vm.confirmPassword = "";
      vm.localError = "";
    });
  }
};
</script>

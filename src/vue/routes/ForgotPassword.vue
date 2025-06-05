<template>
  <div class="auth-page">
    <div class="container page">
      <div class="row">
        <div class="col-md-6 offset-md-3 col-xs-12">
          <h1 class="text-xs-center">Forgot Password</h1>
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

            <button class="btn btn-lg btn-primary pull-xs-right">
              Send Reset Link
            </button>

            <div v-if="successMessage" class="success-message mt-3">
              {{ successMessage }}
            </div>
            <div v-if="localError" class="error-messages mt-3">
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
  name: "ForgotPassword",
  data() {
    return {
      email: "",
      localError: "",
      successMessage: "",
      generatedCode: null,
    };
  },
  computed: {
    ...mapGetters(["errors"])
  },
  methods: {
    async submit() {
      this.localError = "";
      this.successMessage = "";
      this.generatedCode = null;

      try {
        const response = await this.$store.dispatch("requestPasswordReset", {
          email: this.email
        });

        if (!response || !response.message) {
          this.localError = "User not found or something went wrong.";
          return;
        }

        // Генерируем 6-значный код
        const generatedCode = Math.floor(100000 + Math.random() * 900000).toString();
        this.generatedCode = generatedCode;

        // Строим HTML-контент модалки
        const wrapper = document.createElement("div");

        const codeText = document.createElement("p");
        codeText.innerHTML = `Your confirmation code: <strong>${generatedCode}</strong>`;
        codeText.style.marginBottom = "15px";

        const input = document.createElement("input");
        input.setAttribute("placeholder", "Enter code");
        input.setAttribute("type", "text");
        input.className = "swal-content__input";
        input.required = true;

        wrapper.appendChild(codeText);
        wrapper.appendChild(input);

        const result = await swal({
          title: "Confirm Email",
          content: wrapper,
          buttons: ["Cancel", "Submit"]
        });

        if (!result) return;

        const enteredCode = input.value.trim();

        if (!enteredCode) {
          this.localError = "Code is required.";
          return;
        }

        if (enteredCode === this.generatedCode) {
          await swal("Success!", "Redirecting to reset page...", "success");

          // Сохраняем email в sessionStorage
          sessionStorage.setItem("reset_email", this.email);

          // Переход без query
          this.$router.push({ name: "reset-password" });

          // Очищаем email после редиректа
          this.email = "";
        } else {
          this.localError = "Invalid code. Try again.";
        }
      } catch (err) {
        if (
          err &&
          err.errors &&
          err.errors.body &&
          Array.isArray(err.errors.body)
        ) {
          this.localError = err.errors.body.join(" ");
        } else if (err && err.message) {
          this.localError = err.message;
        } else {
          this.localError = "Unexpected error occurred.";
        }
      }
    }
  }
};
</script>

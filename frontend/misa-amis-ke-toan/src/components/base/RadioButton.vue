/**
<template>
  <label class="wrapper flex items-center">
    {{label}}
    <input class="checkbox" type="radio" :checked="isChecked" :value="value" @change="$emit('change', $event.target.value)" />
    <span class="checkmark"></span>
  </label>
</template>

<script>
export default {
  model: {
    prop: 'modelValue',
    event: 'change'
  },
  props: {
    "label": { type: String, default: "", required:true },
    "modelValue": {default: undefined },
    "value": { type: Number, default: undefined }
  },
  computed: {
    isChecked() {
      return this.modelValue == this.value
    }
  }
}
</script>

<style lang="postcss" scoped>
/* Customize the label (the wrapper) */
.wrapper {
  display: block;
  position: relative;
  padding-left: 25px;
  cursor: pointer;
  user-select: none;
}
/* Hide the browser's default radio button */
.wrapper input {
  position: absolute;
  opacity: 0;
  cursor: pointer;
  height: 0;
  width: 0;
}
/* Create a custom radio button */
.checkmark {
  position: absolute;
  top: 0;
  left: 0;
  height: 18px;
  width: 18px;
  border-radius: 50%;
  background-color: #fff;
  border: 1px solid #c7c7c7;
}

/* On mouse-over, add a grey background color */
.wrapper:hover input ~ .checkmark {
  box-shadow: 0px 0px 2px 1px #2ca01c;
}
/* When the radio button is checked, add a blue background */
.wrapper input:checked ~ .checkmark {
  border: 1px solid #2ca01c;
}
/* When the radio button is checked, add a blue background */
.wrapper input:focus ~ .checkmark {
  box-shadow: 0px 0px 2px 1px #2ca01c;
}
/* Create the indicator (the dot/circle - hidden when not checked) */
.checkmark:after {
  content: "";
  position: absolute;
  display: none;
}
/* Show the indicator (dot/circle) when checked */
.wrapper input:checked ~ .checkmark:after {
  display: block;
}
/* Style the indicator (dot/circle) */
.wrapper .checkmark:after {
  top: 3px;
  left: 3px;
  width: 10px;
  height: 10px;
  border-radius: 50%;
  background: #2ca01c;
}
</style>
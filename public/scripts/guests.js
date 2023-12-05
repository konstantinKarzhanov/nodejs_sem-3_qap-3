// Define required variables
const list = document.querySelector("#list--guests");
const form = document.forms["form--guests"];
const inputArr = Array.from(new FormData(form).keys(), (item) => form[item]);
const {
  "btn--reset": btnReset,
  "btn--submit": btnSubmit,
  "btn--delete": btnDelete,
} = form;

// Define a function to set initial state of the buttons
const setInitialBtnState = () => {
  btnSubmit.textContent = "Add";

  btnReset.disabled = true;
  btnSubmit.disabled = true;
  btnDelete.disabled = true;
};

// Define a function to set state of the buttons based on the inputs value
const setBtnState = (...args) => {
  if (args.every((item) => item.value.trim() != "")) {
    btnReset.disabled = false;
    btnSubmit.disabled = false;
    btnDelete.disabled = false;
  } else if (args.some((item) => item.value.trim() != "")) {
    btnReset.disabled = false;
    btnSubmit.disabled = true;
    btnDelete.disabled = false;
  } else {
    setInitialBtnState();
  }
};

// Define a function to set inputs value using the target element's value
const setInputValue = (target, ...args) => {
  const targetArr = target.textContent.split(", ");

  args.forEach((item, index) => {
    item.value = targetArr[index];
  });
};

// Define a function to handle "click" event
const handleClick = (event) => {
  const target = event.target.closest("li");

  if (!target) return;

  setInputValue(target, ...inputArr);
  btnSubmit.textContent = "Update";

  setBtnState(...inputArr);
};

// Define a function to handle "input" event
const handleInput = () => setBtnState(...inputArr);

// Define a function to handle "reset" event
const handleReset = () => setInitialBtnState();

// Define a function to handle "submit" event
function handleSubmit(event) {
  event.preventDefault();

  const { submitter } = event;
  const text = submitter.textContent.toLowerCase();
  const method =
    text == "update" ? "patch" : text == "delete" ? "delete" : "post";

  this.action = `?_method=${method}`;
  this.submit();
}

// Add listeners to the html elements
list.addEventListener("click", handleClick);
form.addEventListener("input", handleInput);
form.addEventListener("reset", handleReset);
form.addEventListener("submit", handleSubmit);

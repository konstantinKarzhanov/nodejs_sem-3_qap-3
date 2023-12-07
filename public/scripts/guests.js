// Define required variables
const list = document.querySelector("#list--guests");
const form = document.forms["form--guests"];
const formDataInputArr = Array.from(
  new FormData(form).keys(),
  (item) => form[item]
);
const formDataInputSubArr = formDataInputArr.reduce((acc, current) => {
  if (current.name.includes("guest_")) {
    acc.push(current);
  }
  return acc;
}, []);
const {
  "btn--reset": btnReset,
  "btn--submit": btnSubmit,
  "btn--delete": btnDelete,
} = form;

// Define a function to set initial state of the buttons
const setControlsToInitialState = () => {
  formDataInputArr.forEach(
    (item) => (item.value = item.type == "hidden" ? "" : item.value)
  );
  btnSubmit.textContent = "Add";

  btnReset.disabled = true;
  btnSubmit.disabled = true;
  btnDelete.disabled = true;
};

// Define a function to set state of the buttons based on the inputs value
const setBtnState = (arr, subArr) => {
  if (arr.every((item) => item.value.trim() != "")) {
    btnReset.disabled = false;
    btnSubmit.disabled = false;
    btnDelete.disabled = false;
  } else if (arr.every((item) => item.value.trim() == "")) {
    setControlsToInitialState();
  } else if (subArr.some((item) => item.value.trim() != "")) {
    btnReset.disabled = false;
    btnSubmit.disabled = true;
    btnDelete.disabled = false;
  } else {
    btnReset.disabled = false;
    btnSubmit.disabled = true;
    btnDelete.disabled = true;
  }
};

// Define a function to set inputs value using the target element's id and text content
const setInputValue = (target, arr) => {
  const { id, textContent } = target;
  const targetArr = [id.split("-").at(-1), ...textContent.split(", ")];

  arr.forEach((item, index) => {
    item.value = targetArr[index];
  });
};

// Define a function to confirm submittion
const confirmSubmit = (arr, message) => {
  const data = arr
    .map(({ value, parentElement }) => {
      if (value.trim() != "")
        return `${parentElement.textContent.trim()}: "${value}"\n`;
    })
    .join("");

  return confirm(`${message}:\n\n${data}`);
};

// Define a function to handle "click" event
const handleClick = (event) => {
  const target = event.target.closest("li");

  if (!target) return;

  setInputValue(target, formDataInputArr);
  btnSubmit.textContent = "Update";

  setBtnState(formDataInputArr.slice(1), formDataInputSubArr.slice(1));
};

// Define a function to handle "input" event
const handleInput = () =>
  setBtnState(formDataInputArr.slice(1), formDataInputSubArr.slice(1));

// Define a function to handle "reset" event
const handleReset = () => setControlsToInitialState();

// Define a function to handle "submit" event
function handleSubmit(event) {
  event.preventDefault();

  const { submitter } = event;
  const text = submitter.textContent.toLowerCase();

  let isConfirmed = true;
  let message = "";
  if (text == "delete") {
    message =
      "Click 'OK' if you want to delete ALL records which have data like";
    isConfirmed = confirmSubmit(formDataInputSubArr.slice(1), message);
  } else if (text == "update") {
    message = "Click 'OK' if you want to update record with new data";
    isConfirmed = confirmSubmit(formDataInputArr.slice(1), message);
  }

  if (!isConfirmed) return;

  this.action = `?_method=${
    text == "add"
      ? "post"
      : text == "update"
      ? "patch"
      : text == "delete"
      ? "delete"
      : "get"
  }`;
  this.submit();
}

// Add listeners to the html elements
list.addEventListener("click", handleClick);
form.addEventListener("input", handleInput);
form.addEventListener("reset", handleReset);
form.addEventListener("submit", handleSubmit);

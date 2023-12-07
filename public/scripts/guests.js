// Import required functions/variables from custom modules
import {
  setValueOfHiddenControl,
  setControlValue,
  setInitialBtnState,
  setBtnState,
  confirmSubmit,
} from "./guestsUtils.js";

// Define required variables
const list = document.querySelector("#list--guests");
const form = document.forms["form--guests"];
const formDataControlArr = Array.from(
  new FormData(form).keys(),
  (item) => form[item]
);
const formDataControlSubArr = formDataControlArr.reduce((acc, current) => {
  if (current.name.includes("guest_")) {
    acc.push(current);
  }
  return acc;
}, []);

const btnObjArr = [...form.elements].reduce((acc, current) => {
  if (current.tagName == "BUTTON") acc.push(current);
  return acc;
}, []);

// Define a function to handle "click" event
const handleClick = (event) => {
  const target = event.target.closest("li");

  if (!target) return;

  setControlValue(target, formDataControlArr);

  btnObjArr.forEach((item) => {
    if (item.id == "btn--post") item.textContent = "Update";
  });

  setBtnState(formDataControlArr, formDataControlSubArr, btnObjArr);
};

// Define a function to handle "input" event
const handleInput = () =>
  setBtnState(formDataControlArr, formDataControlSubArr, btnObjArr);

// Define a function to handle "reset" event
const handleReset = () => {
  setValueOfHiddenControl(formDataControlArr);
  setInitialBtnState(btnObjArr);
};

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
    isConfirmed = confirmSubmit(formDataControlSubArr.slice(1), message);
  } else if (text == "update") {
    message = "Click 'OK' if you want to update record with new data";
    isConfirmed = confirmSubmit(formDataControlArr.slice(1), message);
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

// Define required variables
const list = document.querySelector("#list--guests");
const form = document.forms["form--guests"];
const {
  "btn--reset": btnReset,
  "btn--submit": btnSubmit,
  "btn--delete": btnDelete,
  fname,
  lname,
} = form;

// Define a function to set initial state of the buttons
const setInitialBtnState = () => {
  btnSubmit.value = "Add";

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
  const dataArr = target.textContent.split(" ");
  console.log(dataArr);
  args.forEach((item, index) => {
    item.value = dataArr[index];
    console.log(`value: "${item.value}"`);
  });
};

// Define a function to handle "click" event
const handleClick = (event) => {
  const target = event.target.closest("li");

  if (!target) return;

  btnSubmit.value = "Update";

  setInputValue(target, fname, lname);
  setBtnState(fname, lname);
};

// Define a function to handle "input" event
const handleInput = () => setBtnState(fname, lname);

// Define a function to handle "reset" event
const handleReset = () => setInitialBtnState();

// Add listeners to the html elements
list.addEventListener("click", handleClick);
form.addEventListener("input", handleInput);
form.addEventListener("reset", handleReset);

// form.addEventListener("submit", async (event) => {
//   event.preventDefault();

//   // await fetch("http://localhost:3000/guests", {
//   //   method: "post",
//   //   headers: {
//   //     "Content-Type": "application/json",
//   //   },
//   //   body: JSON.stringify(formData),
//   // });

//   // const formData = new URLSearchParams();

//   // for (const key in inputsObj) {
//   //   formData.append(key, inputsObj[key]);
//   // }

//   // await fetch("http://localhost:3000/guests", {
//   //   method: "post",
//   //   headers: {
//   //     "Content-Type": "application/x-www-form-urlencoded",
//   //   },
//   //   body: formData,
//   // });
// });

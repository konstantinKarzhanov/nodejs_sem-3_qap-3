// Define required variables
const list = document.querySelector("#list--guests");
const form = document.forms["form--guests"];
const {
  "btn--reset": btnReset,
  "btn--submit": btnSubmit,
  "btn--delete": btnDelete,
} = form;
const inputArr = [
  form.fname,
  form.lname,
  form.dob,
  form.email,
  form.phone,
  form.street,
  form.city,
  form.province,
  form.postal_code,
];

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
  const targetArr = target.textContent.split(", ");

  args.forEach((item, index) => {
    item.value = targetArr[index];
  });
};

// Define a function to send a request
const fetchData = async (url, body) => {
  await fetch(url, {
    method: "post",
    headers: {
      "Content-Type": "application/x-www-form-urlencoded",
    },
    body: body,
  });
};

// const fetchData = async (url, method, body) => {
//   await fetch(url, {
//     method: method,
//     headers: {
//       "Content-Type": "application/x-www-form-urlencoded",
//     },
//     body: body,
//   });
// };

// Define a function to handle "click" event
const handleClick = (event) => {
  const target = event.target.closest("li");

  if (!target) return;

  setInputValue(target, ...inputArr);
  btnSubmit.value = "Update";

  setBtnState(...inputArr);
};

// Define a function to handle "input" event
const handleInput = () => setBtnState(...inputArr);

// Define a function to handle "reset" event
const handleReset = () => setInitialBtnState();

// Define a function to handle "submit" event
const handleSubmit = async (event) => {
  event.preventDefault();

  const submitter = event.submitter.value.toLowerCase();
  const method =
    submitter == "update" ? "patch" : submitter == "delete" ? "delete" : "post";
  const formData = new URLSearchParams();

  for (const { name, value } of inputArr) {
    formData.append(name, value);
  }

  await fetchData(`http://localhost:3000/guests?_method=${method}`, formData);
  // await fetchData(`http://localhost:3000/guests`, method, formData);
};

// Add listeners to the html elements
list.addEventListener("click", handleClick);
form.addEventListener("input", handleInput);
form.addEventListener("reset", handleReset);
form.addEventListener("submit", handleSubmit);

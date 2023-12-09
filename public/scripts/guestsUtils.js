// Define a function to set value of the "hidden" controls
const setValueOfHiddenControl = (controlArr) => {
  controlArr.forEach(
    (item) => (item.value = item.type == "hidden" ? "" : item.value)
  );
};

// Define a function to set controls value using the target element's id and text content
const setControlValue = (target, controlArr) => {
  const { id, textContent } = target;
  const targetArr = [id.split("-").at(-1), ...textContent.split(", ")];

  controlArr.forEach((item, index) => {
    item.value = targetArr[index];
  });
};

// Define a function to set initial state of the buttons
const setInitialBtnState = (btnArr) => {
  btnArr.forEach((item) => {
    if (item.id == "btn--post") item.textContent = "Add";

    item.disabled = true;
  });
};

// Define a function to set state of the buttons based on the controls value
const setBtnState = (controlArr, controlSubArr, btnArr) => {
  if (controlArr.slice(1).every((item) => item.value.trim() != "")) {
    // Allow to RESET, ADD, UPDATE, DELETE
    btnArr.forEach((item) => (item.disabled = false));
  } else if (controlArr.slice(1).every((item) => item.value.trim() == "")) {
    // Allow nothing
    setValueOfHiddenControl(controlArr);
    setInitialBtnState(btnArr);
  } else if (controlSubArr.slice(1).every((item) => item.value.trim() == "")) {
    // Allow to RESET, UPDATE
    btnArr.forEach((item) => {
      if (
        item.id == "btn--delete" ||
        (item.id == "btn--post" && item.textContent.toLowerCase() == "add")
      ) {
        item.disabled = true;
      } else {
        item.disabled = false;
      }
    });
  } else {
    // Allow to RESET, UPDATE, DELETE
    btnArr.forEach((item) => {
      if (item.id == "btn--post" && item.textContent.toLowerCase() == "add") {
        item.disabled = true;
      } else {
        item.disabled = false;
      }
    });
  }
};

// Define a function to confirm submittion
const confirmSubmit = (controlArr, message) => {
  const data = controlArr
    .map(({ value, parentElement }) => {
      if (value.trim() != "")
        return `${parentElement.textContent.trim()}: "${value}"\n`;
    })
    .join("");

  return confirm(`${message}:\n\n${data}`);
};

// Export functions/variables to use in other modules
export {
  setValueOfHiddenControl,
  setControlValue,
  setInitialBtnState,
  setBtnState,
  confirmSubmit,
};

export function removeAllChildNodes(parent) {
  while (parent.firstChild) {
    parent.removeChild(parent.firstChild);
  }
}

export  function correctCheckedElements(radioBtnOrCheckBox) {
  return Array.prototype.filter.call(radioBtnOrCheckBox, (element) => element.checked);
}

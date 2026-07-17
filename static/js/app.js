document.addEventListener('DOMContentLoaded', () => {
  const todayFields = document.querySelectorAll('input[type="date"][data-today="true"]');
  const today = new Date().toISOString().split('T')[0];
  todayFields.forEach((field) => {
    if (!field.value) field.value = today;
  });
});

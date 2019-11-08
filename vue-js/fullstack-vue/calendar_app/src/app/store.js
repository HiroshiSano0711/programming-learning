import Vue from 'vue';
import { seedData } from './seed.js';

export const store = {
  state: {
    seedData
  },
  getActiveDay() {
    return this.state.seedData.find((day) => day.active);
  },
  setActiveDay(dayId) {
    this.state.seedData.map((dayObj) => {
      dayObj.id === dayId ? dayObj.active = true : dayObj.active = false;
    });
  },
  submitEvent(eventDetails) {
    const activeDay = this.getActiveDay();
    activeDay.events.push({ "details": eventDetails, "edit": false });
  },
  getEventOjb(dayId, eventDetails) {
    const dayObj = this.state.seedData.find(
      day => day.id === dayId
    );
    console.log(dayObj.events.find(event => event.details === eventDetails));
    return dayObj.events.find(
      event => event.details === eventDetails
    );
  },
  editEvent(dayId, eventDetails) {
    this.resetEditOfAllEvents();
    const eventObj = this.getEventOjb(dayId, eventDetails);
    eventObj.edit = true;
  },
  updateEvent(dayId, originalEventDetials, newEventDetails) {
    const eventObj = this.getEventOjb(dayId, originalEventDetials);
    eventObj.details = newEventDetails;
    eventObj.edit = false;
  },
  resetEditOfAllEvents() {
    this.state.seedData.map((dayObj) => {
      dayObj.events.map((event) => {
        event.edit = false;
      });
    });
  }
}

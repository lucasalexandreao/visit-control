// Import and register all your controllers from the importmap via controllers/**/*_controller
import { application } from "controllers/application"
import { eagerLoadControllersFrom } from "@hotwired/stimulus-loading"
import CameraController from "controllers/camera_controller";

application.register("camera", CameraController);
eagerLoadControllersFrom("controllers", application)

package com.zigcraft.app;

import android.app.Activity;
import android.content.Context;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.graphics.Canvas;
import android.graphics.Color;
import android.graphics.Paint;
import android.graphics.Rect;
import android.graphics.RectF;
import android.opengl.GLSurfaceView;
import android.os.Build;
import android.os.Bundle;
import android.os.VibrationEffect;
import android.os.Vibrator;
import android.util.Log;
import android.view.MotionEvent;
import android.view.View;
import android.view.WindowInsets;
import android.view.WindowInsetsController;
import android.view.WindowManager;
import android.widget.FrameLayout;

import java.util.ArrayList;
import java.util.List;

import javax.microedition.khronos.egl.EGLConfig;
import javax.microedition.khronos.opengles.GL10;

public class MainActivity extends Activity {
    private static final String TAG = "Zigcraft";
    private static boolean sLibraryLoaded = false;

    static {
        try {
            System.loadLibrary("zigcraft");
            sLibraryLoaded = true;
            Log.i(TAG, "Native library 'zigcraft' loaded successfully.");
        } catch (UnsatisfiedLinkError e) {
            Log.w(TAG, "Running with mock native layer: " + e.getMessage());
        }
    }

    public static native void nativeInit();
    public static native void nativeResize(int width, int height);
    public static native void nativeRender();
    public static native void nativeTouch(int action, float x, float y, int pointerId);
    public static native void nativeMovementInput(float forward, float strafe, float lookDx, float lookDy, boolean jump);
    public static native void nativeDestroy();

    private GLSurfaceView mGLView;
    private CubiqTouchOverlayView mTouchOverlay;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        hideSystemUI();

        FrameLayout rootLayout = new FrameLayout(this);

        // 1. OpenGL ES 3.0 Game Surface
        mGLView = new GLSurfaceView(this);
        mGLView.setEGLContextClientVersion(3);
        mGLView.setRenderer(new GLSurfaceView.Renderer() {
            @Override
            public void onSurfaceCreated(GL10 gl, EGLConfig config) {
                if (sLibraryLoaded) {
                    nativeInit();
                }
            }

            @Override
            public void onSurfaceChanged(GL10 gl, int width, int height) {
                if (sLibraryLoaded) {
                    nativeResize(width, height);
                }
            }

            @Override
            public void onDrawFrame(GL10 gl) {
                if (sLibraryLoaded) {
                    nativeRender();
                } else {
                    gl.glClearColor(0.4f, 0.65f, 0.95f, 1.0f);
                    gl.glClear(GL10.GL_COLOR_BUFFER_BIT | GL10.GL_DEPTH_BUFFER_BIT);
                }
            }
        });
        rootLayout.addView(mGLView);

        // 2. Cubiq Awesome Touch Controls Overlay
        mTouchOverlay = new CubiqTouchOverlayView(this);
        rootLayout.addView(mTouchOverlay);

        setContentView(rootLayout);
    }

    @Override
    protected void onResume() {
        super.onResume();
        hideSystemUI();
        if (mGLView != null) mGLView.onResume();
    }

    @Override
    protected void onPause() {
        super.onPause();
        if (mGLView != null) mGLView.onPause();
    }

    @Override
    protected void onDestroy() {
        super.onDestroy();
        if (sLibraryLoaded) {
            nativeDestroy();
        }
    }

    private void hideSystemUI() {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.R) {
            final WindowInsetsController controller = getWindow().getInsetsController();
            if (controller != null) {
                controller.hide(WindowInsets.Type.statusBars() | WindowInsets.Type.navigationBars());
                controller.setSystemBarsBehavior(WindowInsetsController.BEHAVIOR_SHOW_TRANSIENT_BARS_BY_SWIPE);
            }
        } else {
            getWindow().setFlags(
                WindowManager.LayoutParams.FLAG_FULLSCREEN,
                WindowManager.LayoutParams.FLAG_FULLSCREEN
            );
            getWindow().getDecorView().setSystemUiVisibility(
                View.SYSTEM_UI_FLAG_LAYOUT_STABLE
                | View.SYSTEM_UI_FLAG_LAYOUT_HIDE_NAVIGATION
                | View.SYSTEM_UI_FLAG_LAYOUT_FULLSCREEN
                | View.SYSTEM_UI_FLAG_HIDE_NAVIGATION
                | View.SYSTEM_UI_FLAG_FULLSCREEN
                | View.SYSTEM_UI_FLAG_IMMERSIVE_STICKY
            );
        }
    }

    /**
     * CubiqTouchOverlayView
     * Faithful port of Cubiq Launcher's Bedrock / Pocket Edition on-screen controller
     * using the authentic button assets from LayerController.
     */
    public class CubiqTouchOverlayView extends View {
        private final Paint mPaint = new Paint(Paint.ANTI_ALIAS_FLAG | Paint.FILTER_BITMAP_FLAG);
        private final Paint mTextPaint = new Paint(Paint.ANTI_ALIAS_FLAG);
        private Vibrator mVibrator;

        // Bitmaps loaded from Cubiq-Launcher LayerController drawables
        private Bitmap mBmpJoystickBase;
        private Bitmap mBmpJoystickHandle;
        private Bitmap mBmpJoystickHandlePressed;
        private Bitmap mBmpAttack;
        private Bitmap mBmpAttackPressed;
        private Bitmap mBmpInteract;
        private Bitmap mBmpInteractPressed;
        private Bitmap mBmpJump;
        private Bitmap mBmpJumpPressed;
        private Bitmap mBmpSneak;
        private Bitmap mBmpSneakPressed;
        private Bitmap mBmpSprint;
        private Bitmap mBmpSprintPressed;
        private Bitmap mBmpChat;
        private Bitmap mBmpPause;
        private Bitmap mBmpInventory;
        private Bitmap mBmpF3;
        private Bitmap mBmpF5;
        private Bitmap mBmpCrosshair;

        // Joystick state
        private float mJoyBaseX, mJoyBaseY, mJoyRadius;
        private float mJoyKnobX, mJoyKnobY;
        private int mJoyPointerId = -1;
        private boolean mJoyActive = false;

        // Camera look state
        private int mLookPointerId = -1;
        private float mLastLookX, mLastLookY;

        // Button states
        private boolean mIsAttacking = false;
        private boolean mIsInteracting = false;
        private boolean mIsJumping = false;
        private boolean mIsSneaking = false;
        private boolean mIsSprinting = false;
        private boolean mShowF3Debug = false;
        private int mPerspectiveMode = 0; // 0: 1st person, 1: 3rd person back, 2: 3rd person front
        private int mSelectedHotbarSlot = 0;

        // Button Rectangles (screen coordinates)
        private final RectF mRectAttack = new RectF();
        private final RectF mRectInteract = new RectF();
        private final RectF mRectJump = new RectF();
        private final RectF mRectSneak = new RectF();
        private final RectF mRectSprint = new RectF();
        private final RectF mRectChat = new RectF();
        private final RectF mRectPause = new RectF();
        private final RectF mRectInv = new RectF();
        private final RectF mRectF3 = new RectF();
        private final RectF mRectF5 = new RectF();

        public CubiqTouchOverlayView(Context context) {
            super(context);
            mVibrator = (Vibrator) context.getSystemService(Context.VIBRATOR_SERVICE);

            mTextPaint.setColor(Color.WHITE);
            mTextPaint.setTextSize(32f);
            mTextPaint.setShadowLayer(4f, 2f, 2f, Color.BLACK);

            loadBitmaps();
        }

        private Bitmap decodeDrawable(int resId) {
            try {
                return BitmapFactory.decodeResource(getResources(), resId);
            } catch (Exception e) {
                return null;
            }
        }

        private void loadBitmaps() {
            mBmpJoystickBase = decodeDrawable(R.drawable.joystick_base);
            mBmpJoystickHandle = decodeDrawable(R.drawable.joystick_handle);
            mBmpJoystickHandlePressed = decodeDrawable(R.drawable.joystick_handle_pressed);

            mBmpAttack = decodeDrawable(R.drawable.attack_button);
            if (mBmpAttack == null) mBmpAttack = decodeDrawable(R.drawable.attack);
            mBmpAttackPressed = decodeDrawable(R.drawable.attack_button_pressed);
            if (mBmpAttackPressed == null) mBmpAttackPressed = decodeDrawable(R.drawable.attack_pressed);

            mBmpInteract = decodeDrawable(R.drawable.interact_button);
            mBmpInteractPressed = decodeDrawable(R.drawable.interact_button_pressed);

            mBmpJump = decodeDrawable(R.drawable.jump_button_be2);
            if (mBmpJump == null) mBmpJump = decodeDrawable(R.drawable.jump_button);
            mBmpJumpPressed = decodeDrawable(R.drawable.jump_button_be2_pressed);

            mBmpSneak = decodeDrawable(R.drawable.sneak_button_be2);
            if (mBmpSneak == null) mBmpSneak = decodeDrawable(R.drawable.sneak_button);
            mBmpSneakPressed = decodeDrawable(R.drawable.sneak_button_be2_pressed);

            mBmpSprint = decodeDrawable(R.drawable.sprint_button);
            mBmpSprintPressed = decodeDrawable(R.drawable.sprint_button_pressed);

            mBmpChat = decodeDrawable(R.drawable.chat_button_be2);
            mBmpPause = decodeDrawable(R.drawable.pause_button);
            mBmpInventory = decodeDrawable(R.drawable.inv_button_be2);
            mBmpF3 = decodeDrawable(R.drawable.f3_button_be2);
            mBmpF5 = decodeDrawable(R.drawable.f5_button_be2);
            mBmpCrosshair = decodeDrawable(R.drawable.crosshair);
        }

        private void vibrateFeedback() {
            if (mVibrator != null && mVibrator.hasVibrator()) {
                if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
                    mVibrator.vibrate(VibrationEffect.createOneShot(20, VibrationEffect.DEFAULT_AMPLITUDE));
                } else {
                    mVibrator.vibrate(20);
                }
            }
        }

        @Override
        protected void onSizeChanged(int w, int h, int oldw, int oldh) {
            super.onSizeChanged(w, h, oldw, oldh);

            // Left Joystick position (Cubiq Bedrock style)
            mJoyBaseX = w * 0.14f;
            mJoyBaseY = h * 0.72f;
            mJoyRadius = h * 0.18f;
            mJoyKnobX = mJoyBaseX;
            mJoyKnobY = mJoyBaseY;

            // Right Action Cluster (Cubiq Bedrock button layout)
            float btnSize = h * 0.16f;
            float margin = h * 0.04f;

            // Attack (Sword) - right side
            float atkX = w - btnSize * 2.4f;
            float atkY = h * 0.68f;
            mRectAttack.set(atkX, atkY, atkX + btnSize, atkY + btnSize);

            // Interact / Use block - bottom right
            float useX = w - btnSize * 1.2f;
            float useY = h * 0.54f;
            mRectInteract.set(useX, useY, useX + btnSize, useY + btnSize);

            // Jump - bottom right corner
            float jmpX = w - btnSize * 1.3f;
            float jmpY = h * 0.75f;
            mRectJump.set(jmpX, jmpY, jmpX + btnSize, jmpY + btnSize);

            // Sneak - near jump
            float snkX = w - btnSize * 2.5f;
            float snkY = h * 0.85f;
            mRectSneak.set(snkX, snkY, snkX + btnSize * 0.9f, snkY + btnSize * 0.9f);

            // Sprint toggle - above joystick
            float sprX = mJoyBaseX - btnSize * 0.45f;
            float sprY = mJoyBaseY - mJoyRadius - btnSize * 0.95f;
            mRectSprint.set(sprX, sprY, sprX + btnSize * 0.9f, sprY + btnSize * 0.9f);

            // Top action bar buttons (Cubiq style: Chat, Pause, F3, F5, Inventory)
            float topBtnSize = h * 0.11f;
            float topY = margin;

            mRectF3.set(margin, topY, margin + topBtnSize, topY + topBtnSize);
            mRectF5.set(margin + topBtnSize * 1.3f, topY, margin + topBtnSize * 2.3f, topY + topBtnSize);

            mRectChat.set(w * 0.42f, topY, w * 0.42f + topBtnSize, topY + topBtnSize);
            mRectPause.set(w * 0.54f, topY, w * 0.54f + topBtnSize, topY + topBtnSize);
            mRectInv.set(w - margin - topBtnSize, topY, w - margin, topY + topBtnSize);
        }

        @Override
        public boolean onTouchEvent(MotionEvent event) {
            int action = event.getActionMasked();
            int index = event.getActionIndex();
            int pointerId = event.getPointerId(index);
            float touchX = event.getX(index);
            float touchY = event.getY(index);

            switch (action) {
                case MotionEvent.ACTION_DOWN:
                case MotionEvent.ACTION_POINTER_DOWN: {
                    // Check button taps first
                    if (mRectAttack.contains(touchX, touchY)) {
                        mIsAttacking = true;
                        vibrateFeedback();
                    } else if (mRectInteract.contains(touchX, touchY)) {
                        mIsInteracting = true;
                        vibrateFeedback();
                    } else if (mRectJump.contains(touchX, touchY)) {
                        mIsJumping = true;
                        vibrateFeedback();
                    } else if (mRectSneak.contains(touchX, touchY)) {
                        mIsSneaking = !mIsSneaking;
                        vibrateFeedback();
                    } else if (mRectSprint.contains(touchX, touchY)) {
                        mIsSprinting = !mIsSprinting;
                        vibrateFeedback();
                    } else if (mRectF3.contains(touchX, touchY)) {
                        mShowF3Debug = !mShowF3Debug;
                        vibrateFeedback();
                    } else if (mRectF5.contains(touchX, touchY)) {
                        mPerspectiveMode = (mPerspectiveMode + 1) % 3;
                        vibrateFeedback();
                    } else if (mRectPause.contains(touchX, touchY)) {
                        vibrateFeedback();
                    } else if (mRectChat.contains(touchX, touchY)) {
                        vibrateFeedback();
                    } else if (mRectInv.contains(touchX, touchY)) {
                        vibrateFeedback();
                    } else if (isHotbarTouched(touchX, touchY)) {
                        vibrateFeedback();
                    } else if (touchX < getWidth() * 0.45f) {
                        // Left half: Joystick
                        mJoyPointerId = pointerId;
                        mJoyActive = true;
                        updateJoystickKnob(touchX, touchY);
                    } else {
                        // Right half: Camera look swipe
                        mLookPointerId = pointerId;
                        mLastLookX = touchX;
                        mLastLookY = touchY;
                    }
                    dispatchMovement();
                    break;
                }

                case MotionEvent.ACTION_MOVE: {
                    float lookDx = 0f;
                    float lookDy = 0f;

                    for (int i = 0; i < event.getPointerCount(); i++) {
                        int id = event.getPointerId(i);
                        float px = event.getX(i);
                        float py = event.getY(i);

                        if (id == mJoyPointerId) {
                            updateJoystickKnob(px, py);
                        } else if (id == mLookPointerId) {
                            lookDx += (px - mLastLookX);
                            lookDy += (py - mLastLookY);
                            mLastLookX = px;
                            mLastLookY = py;
                        }
                    }

                    dispatchMovementWithLook(lookDx, lookDy);
                    break;
                }

                case MotionEvent.ACTION_UP:
                case MotionEvent.ACTION_POINTER_UP:
                case MotionEvent.ACTION_CANCEL: {
                    if (pointerId == mJoyPointerId) {
                        mJoyPointerId = -1;
                        mJoyActive = false;
                        mJoyKnobX = mJoyBaseX;
                        mJoyKnobY = mJoyBaseY;
                    } else if (pointerId == mLookPointerId) {
                        mLookPointerId = -1;
                    }

                    if (mRectAttack.contains(touchX, touchY)) mIsAttacking = false;
                    if (mRectInteract.contains(touchX, touchY)) mIsInteracting = false;
                    if (mRectJump.contains(touchX, touchY)) mIsJumping = false;

                    dispatchMovement();
                    break;
                }
            }

            invalidate();
            return true;
        }

        private boolean isHotbarTouched(float x, float y) {
            float hotbarW = getWidth() * 0.52f;
            float hotbarLeft = (getWidth() - hotbarW) * 0.5f;
            float hotbarTop = getHeight() - (getHeight() * 0.12f);
            float hotbarBottom = getHeight() - 10f;

            if (x >= hotbarLeft && x <= hotbarLeft + hotbarW && y >= hotbarTop && y <= hotbarBottom) {
                float slotW = hotbarW / 9f;
                int slot = (int) ((x - hotbarLeft) / slotW);
                if (slot >= 0 && slot < 9) {
                    mSelectedHotbarSlot = slot;
                    return true;
                }
            }
            return false;
        }

        private void updateJoystickKnob(float x, float y) {
            float dx = x - mJoyBaseX;
            float dy = y - mJoyBaseY;
            float dist = (float) Math.hypot(dx, dy);
            if (dist > mJoyRadius) {
                mJoyKnobX = mJoyBaseX + (dx / dist) * mJoyRadius;
                mJoyKnobY = mJoyBaseY + (dy / dist) * mJoyRadius;
            } else {
                mJoyKnobX = x;
                mJoyKnobY = y;
            }
        }

        private void dispatchMovement() {
            dispatchMovementWithLook(0f, 0f);
        }

        private void dispatchMovementWithLook(float lookDx, float lookDy) {
            if (!sLibraryLoaded) return;
            float forward = 0f;
            float strafe = 0f;
            if (mJoyActive) {
                forward = (mJoyBaseY - mJoyKnobY) / mJoyRadius;
                strafe = (mJoyKnobX - mJoyBaseX) / mJoyRadius;
                if (mIsSprinting) {
                    forward *= 1.3f;
                    strafe *= 1.3f;
                }
            }
            nativeMovementInput(forward, strafe, lookDx, lookDy, mIsJumping);
        }

        private void drawButtonBitmap(Canvas canvas, Bitmap defaultBmp, Bitmap pressedBmp, boolean isPressed, RectF dst) {
            Bitmap bmp = (isPressed && pressedBmp != null) ? pressedBmp : defaultBmp;
            if (bmp != null) {
                canvas.drawBitmap(bmp, null, dst, mPaint);
            } else {
                // Fallback rounded rect
                mPaint.setStyle(Paint.Style.FILL);
                mPaint.setColor(isPressed ? 0x804CAF50 : 0x60333333);
                canvas.drawRoundRect(dst, 16f, 16f, mPaint);
                mPaint.setStyle(Paint.Style.STROKE);
                mPaint.setStrokeWidth(3f);
                mPaint.setColor(0xCCFFFFFF);
                canvas.drawRoundRect(dst, 16f, 16f, mPaint);
            }
        }

        @Override
        protected void onDraw(Canvas canvas) {
            super.onDraw(canvas);

            // 1. Draw Cubiq Joystick
            if (mBmpJoystickBase != null) {
                RectF baseDst = new RectF(mJoyBaseX - mJoyRadius, mJoyBaseY - mJoyRadius, mJoyBaseX + mJoyRadius, mJoyBaseY + mJoyRadius);
                canvas.drawBitmap(mBmpJoystickBase, null, baseDst, mPaint);
            } else {
                mPaint.setStyle(Paint.Style.FILL);
                mPaint.setColor(0x40FFFFFF);
                canvas.drawCircle(mJoyBaseX, mJoyBaseY, mJoyRadius, mPaint);
            }

            float handleRadius = mJoyRadius * 0.45f;
            RectF handleDst = new RectF(mJoyKnobX - handleRadius, mJoyKnobY - handleRadius, mJoyKnobX + handleRadius, mJoyKnobY + handleRadius);
            Bitmap handleBmp = mJoyActive ? (mBmpJoystickHandlePressed != null ? mBmpJoystickHandlePressed : mBmpJoystickHandle) : mBmpJoystickHandle;
            if (handleBmp != null) {
                canvas.drawBitmap(handleBmp, null, handleDst, mPaint);
            } else {
                mPaint.setStyle(Paint.Style.FILL);
                mPaint.setColor(0x90FFFFFF);
                canvas.drawCircle(mJoyKnobX, mJoyKnobY, handleRadius, mPaint);
            }

            // 2. Draw Cubiq Action Buttons
            drawButtonBitmap(canvas, mBmpAttack, mBmpAttackPressed, mIsAttacking, mRectAttack);
            drawButtonBitmap(canvas, mBmpInteract, mBmpInteractPressed, mIsInteracting, mRectInteract);
            drawButtonBitmap(canvas, mBmpJump, mBmpJumpPressed, mIsJumping, mRectJump);
            drawButtonBitmap(canvas, mBmpSneak, mBmpSneakPressed, mIsSneaking, mRectSneak);
            drawButtonBitmap(canvas, mBmpSprint, mBmpSprintPressed, mIsSprinting, mRectSprint);

            // 3. Draw Top Action Bar Buttons (Chat, Pause, F3, F5, Inventory)
            drawButtonBitmap(canvas, mBmpF3, null, mShowF3Debug, mRectF3);
            drawButtonBitmap(canvas, mBmpF5, null, mPerspectiveMode != 0, mRectF5);
            drawButtonBitmap(canvas, mBmpChat, null, false, mRectChat);
            drawButtonBitmap(canvas, mBmpPause, null, false, mRectPause);
            drawButtonBitmap(canvas, mBmpInventory, null, false, mRectInv);

            // 4. Draw Center Crosshair
            if (mBmpCrosshair != null) {
                float chSize = 36f;
                float cx = getWidth() * 0.5f;
                float cy = getHeight() * 0.5f;
                RectF chDst = new RectF(cx - chSize * 0.5f, cy - chSize * 0.5f, cx + chSize * 0.5f, cy + chSize * 0.5f);
                canvas.drawBitmap(mBmpCrosshair, null, chDst, mPaint);
            } else {
                float cx = getWidth() * 0.5f;
                float cy = getHeight() * 0.5f;
                mPaint.setColor(0xCCFFFFFF);
                mPaint.setStrokeWidth(3f);
                canvas.drawLine(cx - 16f, cy, cx + 16f, cy, mPaint);
                canvas.drawLine(cx, cy - 16f, cx, cy + 16f, mPaint);
            }

            // 5. Draw 9-Slot Hotbar at bottom center
            float hotbarW = getWidth() * 0.52f;
            float hotbarLeft = (getWidth() - hotbarW) * 0.5f;
            float hotbarH = getHeight() * 0.10f;
            float hotbarTop = getHeight() - hotbarH - 12f;
            float slotW = hotbarW / 9f;

            mPaint.setStyle(Paint.Style.FILL);
            mPaint.setColor(0xA0181818);
            canvas.drawRoundRect(new RectF(hotbarLeft, hotbarTop, hotbarLeft + hotbarW, hotbarTop + hotbarH), 12f, 12f, mPaint);

            for (int i = 0; i < 9; i++) {
                float sx = hotbarLeft + (i * slotW);
                boolean selected = (i == mSelectedHotbarSlot);

                mPaint.setStyle(Paint.Style.STROKE);
                mPaint.setStrokeWidth(selected ? 5f : 2f);
                mPaint.setColor(selected ? Color.WHITE : 0x70808080);
                canvas.drawRoundRect(new RectF(sx + 3f, hotbarTop + 3f, sx + slotW - 3f, hotbarTop + hotbarH - 3f), 8f, 8f, mPaint);

                mTextPaint.setTextSize(26f);
                canvas.drawText(String.valueOf(i + 1), sx + slotW * 0.38f, hotbarTop + hotbarH * 0.65f, mTextPaint);
            }

            // 6. F3 Debug Screen (when toggled)
            if (mShowF3Debug) {
                mTextPaint.setTextSize(24f);
                float dy = 160f;
                canvas.drawText("Zigcraft 1.0 (Cubiq Controller Edition)", 30f, dy, mTextPaint);
                canvas.drawText("FPS: 60.0 (GLES 3.0)", 30f, dy + 32f, mTextPaint);
                canvas.drawText("XYZ: 8.000 / 75.000 / 8.000", 30f, dy + 64f, mTextPaint);
                canvas.drawText("Block: 8 75 8 (Chunk 0, 0)", 30f, dy + 96f, mTextPaint);
                canvas.drawText("Biome: Plains | Light: 15 (15 sky, 0 block)", 30f, dy + 128f, mTextPaint);
                canvas.drawText("Engine: Zig + Odin Hybrid Native Layer", 30f, dy + 160f, mTextPaint);
            }
        }
    }
}

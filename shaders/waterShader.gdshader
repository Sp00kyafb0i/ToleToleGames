shader_type canvas_item;

uniform sampler2D prevImage : hint_screen_texture, repeat_disable;
uniform vec2 cameraPosition;
uniform vec2 screenSize;
uniform vec2 waterSpeed;
uniform float damage;
uniform float escalaGlobal;

float centeredSnap(float x,float n){
	return round(x/n)*n;
}
float lineClosenessTexture(vec2 position,float newGridSize,float p){
	float n = newGridSize;
	float m = newGridSize;
	float distLineX = 2.0*abs(position.x/ escalaGlobal-centeredSnap(position.x/ escalaGlobal,n))/n ;
	float distLineY = 2.0*abs(position.y/ escalaGlobal-centeredSnap(position.y/ escalaGlobal,m))/m ;
	return pow(distLineX,p)+ pow(distLineY,p);
}

float seudoRandom(float a, float b){
	float normalizedNoise =(sin(TIME*10.0/2.0+0.6)
						   +sin(TIME*11.0/2.0+0.7)
						   +sin(TIME*12.0/2.0+0.8))/3.0;
	return normalizedNoise*(b-a) +a;
}
vec4 getMovingWaterTexture(vec2 location, float scale,sampler2D tex){
	vec2 sampleLocation1 = scale*(location + 77.0 + TIME * waterSpeed);
	vec2 sampleLocation2 = scale*(location + TIME * waterSpeed);
	return max(texture(tex,sampleLocation1),1.0-texture(tex,sampleLocation2));
}

float getMask(vec2 position,sampler2D tex,float sharpness,vec3 color,float mult){
	float radius = 4.0; 
	float col = 1.0 - clamp(distance(texture(tex,position,sharpness).rgb,color)*mult,0.0,1.0);
	return  col;
}
void fragment() {
	float gridSize = 70.0;
	vec2 UV_camera = UV + cameraPosition/screenSize;
	vec3 bkColor = vec3(0.3,0.3,0.3);
	vec3 blackholeColor = vec3(1.0,0.0,0.0);
	vec4 waterTex =getMovingWaterTexture( UV_camera,0.6,TEXTURE);
	vec2 offset = (waterTex.xy-0.5+vec2(0.9,0.0))*0.07;
	float waterMask = waterTex.x;
	float blackholeMask =getMask(SCREEN_UV,prevImage,0.5,blackholeColor,10.0);
	float mask = 1.0-getMask(SCREEN_UV,prevImage,0.0,bkColor,10.0);
	float difuseMask = getMask(SCREEN_UV-offset,prevImage,4.0,bkColor,10.0)//1.0+getMask(SCREEN_UV-offset,prevImage,4.0,bkColor)
					   -getMask(SCREEN_UV,prevImage,4.0,bkColor,1.0);
	float difuseBlackholeMask = getMask(SCREEN_UV,prevImage,10.0,blackholeColor,1.0);
	mask -= blackholeMask;
	vec2 sampleLinePosition = UV_camera*screenSize 
							+difuseMask*waterSpeed*200.0;
	gridSize -= difuseBlackholeMask*20.0;
	float lineMapTail = lineClosenessTexture(sampleLinePosition,gridSize,10.0);
	float lineMapHighlight = lineClosenessTexture(sampleLinePosition,gridSize,70.0)*1.0;
	float lineMapFlashes = lineClosenessTexture(sampleLinePosition,gridSize,10.0)*10.0;
	float lineSmallLines = lineClosenessTexture(sampleLinePosition+waterTex.xy*60.0,gridSize/3.0,5.0);
	
float l = seudoRandom(damage,1.0-damage)*damage*1.5;
COLOR=  vec4(	 ( (lineMapTail)			*(1.0-mask)   * (vec3(0.9,0.16,0.5)*l+vec3(0.0,0.16,0.5)*(1.0-l))
				+ (lineMapHighlight)	* vec3(1.0,1.0,1.0)*(1.0-mask)
				+ (lineMapFlashes * pow(waterMask,4.0)*1.0) * vec3(0.41,0.89,0.84)*(1.0-mask)
				+ (lineSmallLines) * vec3(0.0,0.0,0.1)*(1.0-mask)
				+ vec3(0.0,0.15,0.3) * waterMask ) *  (-difuseBlackholeMask*0.7+0.7)
				,1.0) + texture(prevImage,SCREEN_UV)*mask;
				+pow( max(1.0-difuseMask,0.0)*0.3 , 2.0) *   vec4(0.41,0.89,0.84,0.0);
	//COLOR =  vec4(vec3(1.0,0.0,0.0) * damage,1.0);
}



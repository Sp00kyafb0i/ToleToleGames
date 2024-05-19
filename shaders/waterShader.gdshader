shader_type canvas_item;

uniform sampler2D prevImage : hint_screen_texture, repeat_disable;
uniform vec2 cameraPosition;
uniform vec2 screenSize;
uniform vec2 waterSpeed;
uniform float gridSize;

float centeredSnap(float x,float n){
	return round(x/n)*n;
}
float lineClosenessTexture(vec2 position,float newGridSize,float p){
	float n = newGridSize;
	float m = newGridSize;
	float distLineX = 2.0*abs(position.x-centeredSnap(position.x,n))/n;
	float distLineY = 2.0*abs(position.y-centeredSnap(position.y,m))/m;
	return pow(distLineX,p)+ pow(distLineY,p);
}

float seudoRandom(float a, float b){
	float normalizedNoise =(sin(TIME*10.0+0.6)
						   +sin(TIME*11.0+0.7)
						   +sin(TIME*12.0+0.8))/3.0;
	return normalizedNoise*(b-a) +a;
}
vec4 getMovingWaterTexture(vec2 location, float scale,sampler2D tex){
	vec2 sampleLocation1 = scale*(location + 77.0 + TIME * waterSpeed);
	vec2 sampleLocation2 = scale*(location + TIME * waterSpeed);
	return max(texture(tex,sampleLocation1),1.0-texture(tex,sampleLocation2));
}

float getMaskTexture(vec2 position,sampler2D prev,vec2 ps){
	float radius = 4.0; 
	float col = 1.0-min(distance(texture(prev,position,4.0),vec4(0.3,0.3,0.3,1.0))*10.0,4.0);
	return  col;
}
void fragment() {
	vec2 UV2 = UV + cameraPosition/screenSize;
	vec4 waterTex = getMovingWaterTexture(UV2,0.6,TEXTURE);
	float waterMap = waterTex.x;
	float mask = 1.0-float(distance(texture(prevImage,SCREEN_UV),vec4(0.3,0.3,0.3,1.0)) < 0.01);
	float difuseMask = 1.0-getMaskTexture(SCREEN_UV+waterTex.xy*0.07,prevImage,TEXTURE_PIXEL_SIZE)
					   +getMaskTexture(SCREEN_UV,prevImage,TEXTURE_PIXEL_SIZE);
	float lineMapTail = lineClosenessTexture(UV2*screenSize+difuseMask*waterSpeed*200.0,gridSize,10.0);
	float lineMapHighlight = lineClosenessTexture(UV2*screenSize+difuseMask*waterSpeed*200.0,gridSize,70.0)*1.0;
	float lineMapFlashes = lineClosenessTexture(UV2*screenSize+difuseMask*waterSpeed*200.0,gridSize,10.0)*10.0;
	float lineSmallLines = lineClosenessTexture(UV2*screenSize+waterTex.xy*60.0,gridSize/3.0,5.0);
	
float l = seudoRandom(0.0,1.0);
COLOR=  vec4(	 ( (lineMapTail)			*(1.0-mask)   * (vec3(0.2,0.16,0.5)*l+vec3(0.0,0.16,0.5)*(1.0-l))
				+ (lineMapHighlight)	* vec3(1.0,1.0,1.0)*(1.0-mask)
				+ (lineMapFlashes * pow(waterMap,4.0)*1.0) * vec3(0.41,0.89,0.84)*(1.0-mask)
				+ (lineSmallLines) * vec3(0.0,0.0,0.1)*(1.0-mask)
				+ vec3(0.0,0.15,0.3) * waterMap ) * 0.7
				,1.0) + texture(prevImage,SCREEN_UV)*mask
				+pow( max(1.0-difuseMask,0.0)*0.3 , 2.0) *   vec4(0.41,0.89,0.84,0.0);
//COLOR+=  vec4(vec3(0.0,1.0,0.0) * mask * 0.5,1.0);
}


